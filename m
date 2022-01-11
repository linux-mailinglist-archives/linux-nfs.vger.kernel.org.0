Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 985E748B7C3
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jan 2022 21:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241992AbiAKUCU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Jan 2022 15:02:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241741AbiAKUCU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Jan 2022 15:02:20 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218DFC06173F
        for <linux-nfs@vger.kernel.org>; Tue, 11 Jan 2022 12:02:20 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id BCBEF70C2; Tue, 11 Jan 2022 15:02:19 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org BCBEF70C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1641931339;
        bh=DOrGvmfL2kXJ+h9oD1kxavjld5dzs+iGLopav/Cn2No=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cjpM66NI7u4JfRjdaqp9OD+UGVwF8ZB0NbjvuPb1PTK3VF7G2NILsoGFWKg2G779P
         Vpd/BX7O+piccdFRSKS/+5jW0q9xmUL9KkJ9jnxCOwqCyfoAUQ97Cp6E5sL/WKHQbg
         /COqurPLZ8I1FAS5GOTEgCp9IhiocK6VVcMzUw74=
Date:   Tue, 11 Jan 2022 15:02:19 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-nfs@vger.kernel.org, luis.turcitu@appsbroker.com,
        chris.chilvers@appsbroker.com, david.young@appsbroker.com,
        daire@dneg.com, david.oberhollenzer@sigma-star.at,
        david@sigma-star.at, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com
Subject: Re: [RFC PATCH 0/3] Dealing with NFS re-export and cross mounts
Message-ID: <20220111200219.GE4035@fieldses.org>
References: <20220110184419.27665-1-richard@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220110184419.27665-1-richard@nod.at>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jan 10, 2022 at 07:44:16PM +0100, Richard Weinberger wrote:
> Currently when re-exporting a NFS share the NFS cross mount feature does
> not work [0].
> This RFC patch series outlines an approach to address the problem.
> 
> Crossing mounts does not work for two reasons:
> 
> 1. As soon the NFS client (on the re-exporting server) sees a different
> filesystem id, it installs an automount. That way the other filesystem
> will be mounted automatically when someone enters the directory.
> But the cross mount logic of KNFS does not know about automount.
> The three patches in this series address the problem and teach both KNFSD
> and the exportfs logic of NFS to deal with automount.
> 
> 2. When KNFSD detects crossing of a mount point, it asks rpc.mountd to install
> a new export for the target mount point. Beside of authentication rpc.mountd
> also has to find a filesystem id for the new export. Is the to be exported
> filesystem a NFS share, rpc.mountd cannot derive a filesystem id from it and
> refuses to export. In the logs you’ll see error such as:
> mountd: Cannot export /srv/nfs/vol0, possibly unsupported filesystem or fsid= required
> To deal with that I changed rpc.mountd to use an arbitrary fsid.
> Since this is a gross hack we need to agree on an approach to derive filesystem
> ids for NFS mounts.
> 
> rpc.mountd could:
> a) re-use the fsid from the original NFS server.
>    Beside of requesting this information, the problem with that approach is
>    that the original fsid might conflict with an existing export.
> b) derive the fsid from stat->st_dev.
> c) allocate a free fsid.
>  
> One use case to consider is load balancing. When multiple NFS servers re-export
> a NFS mount, they need to use the same fsid for crossed mounts.
> So I'm a little puzzled which approach is best. What do you think?
> 
> Known issues:
> - Only tested with NFSv3 (both server and client) so far.
> 
> [0] https://marc.info/?l=linux-nfs&m=161653016627277&w=2

v4 testing would definitely be good, that's the case we'll care most
about.

--b.
