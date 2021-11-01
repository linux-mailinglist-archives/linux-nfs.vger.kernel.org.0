Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAB6D4420CF
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Nov 2021 20:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232600AbhKAT2k (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Nov 2021 15:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbhKAT2k (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 1 Nov 2021 15:28:40 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D87C061714
        for <linux-nfs@vger.kernel.org>; Mon,  1 Nov 2021 12:26:06 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 2567B7045; Mon,  1 Nov 2021 15:26:06 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 2567B7045
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1635794766;
        bh=/viBnHPtNMz+L7xrFeIWguhrW2QOg0iMf+GTglrv5fc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mi7ZbEO6Y5fZBiGvNQRumlLRP4MtNdC0s3DqlAPQzUZs4X0kewwUH5Y8NcateZVUn
         aEoCqM3qPBIXInVtNVbQmhyszZCldOwquA92aWfKKBeCnIdkVLrQgY2F7xMQtUYHTU
         hGSn/zInN41JGT4zHHpwReTL5648oLimYBPNlB+s=
Date:   Mon, 1 Nov 2021 15:26:06 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Steve Dickson <steved@redhat.com>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/1] Enable inter server to server copies on a export
Message-ID: <20211101192606.GC14427@fieldses.org>
References: <20211029134534.GA19967@fieldses.org>
 <3e928624-6a7a-8583-7ea4-4eef9c22488e@redhat.com>
 <20211029164058.GE19967@fieldses.org>
 <65b31c94-54aa-5035-546c-75eb0048ba96@redhat.com>
 <20211029191435.GI19967@fieldses.org>
 <ce34c1f2-a0ad-fcb0-99fa-a1ccea8abfd7@redhat.com>
 <20211101154046.GA12965@fieldses.org>
 <93DAB7C7-D0BB-48BA-9BFF-2821D88582EA@oracle.com>
 <20211101183916.GA14427@fieldses.org>
 <79e55dad-7f34-3723-98b0-7c2ef7be9355@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79e55dad-7f34-3723-98b0-7c2ef7be9355@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Nov 01, 2021 at 03:10:31PM -0400, Steve Dickson wrote:
> 
> 
> On 11/1/21 14:39, Bruce Fields wrote:
> >diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> >index 91ba391f9b32..14bc3f0b0149 100644
> >--- a/Documentation/admin-guide/kernel-parameters.txt
> >+++ b/Documentation/admin-guide/kernel-parameters.txt
> >@@ -3243,6 +3243,19 @@
> >  			driver. A non-zero value sets the minimum interval
> >  			in seconds between layoutstats transmissions.
> >+	nfsd.inter_copy_offload_enable =
> >+			[NFSv4.2] When set to 1, the server will support
> >+			server-to-server copies for which this server is
> >+			the destination of the copy.
> >+
> >+	nfsd.nfsd4_ssc_umount_timeout =
> >+			[NFSv4.2] When used as the destination of a
> >+			server-to-server copy, knfsd temporarily mounts
> >+			the source server.  It caches the mount in case
> >+			it will be needed again, and discards it if not
> >+			used for the number of milliseconds specified by
> >+			this parameter.
> >+
> >  	nfsd.nfs4_disable_idmapping=
> >  			[NFSv4] When set to the default of '1', the NFSv4
> >  			server will return only numeric uids and gids to
> >@@ -3250,6 +3263,7 @@
> >  			and gids from such clients.  This is intended to ease
> >  			migration from NFSv2/v3.
> >+
> >  	nmi_backtrace.backtrace_idle [KNL]
> >  			Dump stacks even of idle CPUs in response to an
> >  			NMI stack-backtrace request.
> >
> Interesting... I don't see these in the Linus tree I'm looking at [1]
> find Documentation/ -type f  | xargs grep -i inter_copy_offload_enable

I was suggesting that as a patch.  It's queued up for 5.16 now.

--b.
