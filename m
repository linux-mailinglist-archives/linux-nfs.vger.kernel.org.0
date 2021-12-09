Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 374D246F669
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Dec 2021 23:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbhLIWHA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Thu, 9 Dec 2021 17:07:00 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:36084 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbhLIWHA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 9 Dec 2021 17:07:00 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 90CF4614E2D5;
        Thu,  9 Dec 2021 23:03:25 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id tTdmplOcseml; Thu,  9 Dec 2021 23:03:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 0985C60F6B7D;
        Thu,  9 Dec 2021 23:03:25 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qn1uXTZblCSN; Thu,  9 Dec 2021 23:03:24 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id D7CB962EB595;
        Thu,  9 Dec 2021 23:03:24 +0100 (CET)
Date:   Thu, 9 Dec 2021 23:03:24 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     bfields <bfields@fieldses.org>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>,
        luis turcitu <luis.turcitu@appsbroker.com>,
        chris chilvers <chris.chilvers@appsbroker.com>,
        david young <david.young@appsbroker.com>,
        david <david@sigma-star.at>,
        david oberhollenzer <david.oberhollenzer@sigma-star.at>
Message-ID: <763412597.153709.1639087404752.JavaMail.zimbra@nod.at>
In-Reply-To: <20211209214139.GA23483@fieldses.org>
References: <1576494286.153679.1639083948872.JavaMail.zimbra@nod.at> <20211209214139.GA23483@fieldses.org>
Subject: Re: Improving NFS re-export
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF94 (Linux)/8.8.12_GA_3809)
Thread-Topic: Improving NFS re-export
Thread-Index: ymrsw2Mi5hdsodFOjqZy6pPZSY2Pjg==
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

----- Ursprüngliche Mail -----
> On Thu, Dec 09, 2021 at 10:05:48PM +0100, Richard Weinberger wrote:
>> nfs_encode_fh() in fs/nfs/export.c checks for IS_AUTOMOUNT(inode), if this is
>> the case
>> it refuses to create a new file handle.
>> So while accessing /files/disk2 directly on the re-exporting server triggers an
>> automount,
>> accessing via nfsd the export function of the client side gives up.
>> 
>> AFAIU the suggested proxy-only-mode[1] will not address this problem, right?
> 
> That's how I was thinking of addressing the problem, actually.  I
> haven't figured out how to make that proxy-only mode work, though.
> 
>> One workaround is manually adding an export for each volume on the re-exporting
>> server.
>> This kinda works but is tedious and error prone.
>> 
>> I have a crazy idea how to automate this:
>> Since nfs_encode_fh() in the NFS client side of the re-exporting server can
>> detect
>> crossing mounts, we could install a new export on the sever side as soon the
>> IS_AUTOMOUNT(inode) case arises. We could even use the same fsid.
>> What do you think?
> 
> Something like that might work.
> 
> I'm not sure what you mean by the same fsid.  I think you'd need to make
> up a new fsid each time you encounter a new filesystem.  And you'd also
> want to persist it on disk if you want this to keep working across
> reboots of the proxy.

By same fsid I meant reusing the fsid from the backend server.
 
> I think you could patch rpc.mountd to do that.

Okay, I need to dig into this.

>> Another obstacle is file handle wrapping.
>> When re-exporting, the NFS client side adds inode and file information to each
>> file handle,
>> the server side also adds information. In my test setup this enlarges a 16 bytes
>> file handle
>> to 40 bytes.
>> The proxy-only-mode won't help us either here.
> 
> Part of my motivation for a proxy-only mode was to remove that wrapping.
> 
> Since you're dedicating the host to reexporting one single backend
> server, in theory you don't need any of the information in the wrapper.
> When you (the proxy) get a filehandle from a client, you know which
> server that filehandle originally came from, so you can go ask that
> server for whatever you need to know about the filehandle (like an
> fsid).

I see. That way we could get rid of file handle wrapping but loose the
NFS clinet inode cache on the re-exporting server, I think.
 
>> Did you consider using the opaque file handle from the server as
>> lookup key in a (persisted) data structure?
> 
> A little, but I don't think it works.
> 
> If you do this, you do need to require that you only export one server.
> Otherwise there may be collisions (two different servers could return
> filehandles that happen to have the same value).
> 
> The database would store every filehandle the client has ever seen.
> That could be a lot.  It may also include filehandles for since-deleted
> files.  The only way to prune such entries would be to try using them
> and see if the server gives you STALE errors.

True. I didn't think about the pruning case.

Thanks a lot for the prompt reply and your valuable input.
//richard
