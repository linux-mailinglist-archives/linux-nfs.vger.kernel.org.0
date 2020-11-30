Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF5C2C91D3
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Dec 2020 00:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388816AbgK3W7I (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Nov 2020 17:59:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388811AbgK3W7H (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Nov 2020 17:59:07 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A3BC0613D4
        for <linux-nfs@vger.kernel.org>; Mon, 30 Nov 2020 14:58:43 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id E77F46F4A; Mon, 30 Nov 2020 17:58:42 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org E77F46F4A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1606777122;
        bh=dOI/rdwtm9VxPcujK2qc8LigCNNactIcyohphNcEoU4=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=p9V754GsVSzGVkBn41RI5E1isEOrMl2g3h1odSlhGz6RHsvx+IgWuLSSgg334g9ji
         /oDs1obMmwDgOlk/5+rQslFR5LPPn1w10CnbIPmH9auQQj0UPGuNB2F33y+CH8yFSZ
         GcK73+6eHj7IXy4XnqtXt7AZPauY0NrvDiLKlV34=
Date:   Mon, 30 Nov 2020 17:58:42 -0500
To:     trondmy@kernel.org
Cc:     "J. Bruce Fields" <bfields@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/6] nfsd: add a new EXPORT_OP_NOWCC flag to struct
 export_operations
Message-ID: <20201130225842.GA22446@fieldses.org>
References: <20201130212455.254469-1-trondmy@kernel.org>
 <20201130212455.254469-2-trondmy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130212455.254469-2-trondmy@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This is great, thanks:

On Mon, Nov 30, 2020 at 04:24:50PM -0500, trondmy@kernel.org wrote:
> From: Jeff Layton <jeff.layton@primarydata.com>
> 
> With NFSv3 nfsd will always attempt to send along WCC data to the
> client. This generally involves saving off the in-core inode information
> prior to doing the operation on the given filehandle, and then issuing a
> vfs_getattr to it after the op.
> 
> Some filesystems (particularly clustered or networked ones) have an
> expensive ->getattr inode operation. Atomicitiy is also often difficult
> or impossible to guarantee on such filesystems. For those, we're best
> off not trying to provide WCC information to the client at all, and to
> simply allow it to poll for that information as needed with a GETATTR
> RPC.
> 
> This patch adds a new flags field to struct export_operations, and
> defines a new EXPORT_OP_NOWCC flag that filesystems can use to indicate
> that nfsd should not attempt to provide WCC info in NFSv3 replies. It
> also adds a blurb about the new flags field and flag to the exporting
> documentation.

In the v4 case I think it should also turn off the "atomic" flag in the
change_info4 structure that's returned by some operations.

(Out of curiosity: have you seen this cause actual bugs?)

--b.
