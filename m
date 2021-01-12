Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 486AF2F3431
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Jan 2021 16:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391148AbhALPc7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Jan 2021 10:32:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391538AbhALPc6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 Jan 2021 10:32:58 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF52C0617A9
        for <linux-nfs@vger.kernel.org>; Tue, 12 Jan 2021 07:32:09 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 8A4C96E9F; Tue, 12 Jan 2021 10:32:08 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 8A4C96E9F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1610465528;
        bh=MiDq3PoCR1T9s4qGkpHsVtDv9AbM5/8pKmBaap1iFhM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GV6MnKf6te+aSKBs22gWeJLqa5cT9xvY0p47uYxt/7HdZkxFGduocsY+zWTfuZ45X
         DjxMzTgpY7VGfdOrSvKbw9K9FqtloTgrtuZKBcjHYN0fQ3JqnVY0GgApL0DoTPfOFL
         9zQT9UJVUlKPluckAgZUkGs2tNm6x9635EzT3tPQ=
Date:   Tue, 12 Jan 2021 10:32:08 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     =?utf-8?B?5ZC05byC?= <wangzhibei1999@gmail.com>
Cc:     Willy Tarreau <w@1wt.eu>, Greg KH <greg@kroah.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        "security@kernel.org" <security@kernel.org>,
        linux-nfs@vger.kernel.org
Subject: Re: nfsd vurlerability submit
Message-ID: <20210112153208.GF9248@fieldses.org>
References: <CAHxDmpTKJfnhGY9CVupyVYhNCTDVKBB6KRwh-E6u_XEPJq4WJQ@mail.gmail.com>
 <20210105165633.GC14893@fieldses.org>
 <X/hEB8awvGyMKi6x@kroah.com>
 <20210108152017.GA4183@fieldses.org>
 <20210108152607.GA950@1wt.eu>
 <20210108153237.GB4183@fieldses.org>
 <20210108154230.GB950@1wt.eu>
 <20210111193655.GC2600@fieldses.org>
 <CAHxDmpR1zG25ADfK2jat4VKGbAOCg6YM_0WA+a_jQE82hbnMjA@mail.gmail.com>
 <CAHxDmpRfmVukMR_yF4coioiuzrsp72zBraHWZ8gaMydUuLwKFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHxDmpRfmVukMR_yF4coioiuzrsp72zBraHWZ8gaMydUuLwKFg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jan 12, 2021 at 10:48:00PM +0800, 吴异 wrote:
> Telling users how to configure the exported file system in the most secure
> way does
> mitigate the problem to some extent, but this does not seem to address the
> security risks posed by no_ subtree_ check in the code. In my opinion,when
> the generated filehandle does not contain the inode information of the
> parent directory,the nfsd_acceptable function can also recursively
> determine whether the request file exceeds the export path dentry.Enabling
> subtree_check to add parent directory information only brings some troubles.

Filesystems don't necessarily provide us with an efficient way to find
parent directories from any given file.  (And note a single file may
have multiple parent directories.)

(I do wonder if we could do better in the directory case, though.  We
already reconnect directories all the way back up to the root.)

> I have a bold idea, why not directly remove the file handle modification in
> subtree_check, and then normalize the judgment of whether dentry exceeds
> the export point directory in nfsd_acceptable (line 38 to 54 in
> /fs/nfsd/nfsfh.c) .
> 
> As far as I understand it, the reason why subtree_check is not turned on by
> default is that it will cause problems when reading and writing files,
> rather than it wastes more time when nfsd_acceptable.
> 
> In short,I think it's open to question whether the security of the system
> depends on the user's complete correct configuration(the system does not
> prohibit the export of a subdirectory).

> Enabling subtree_check to add parent directoryinformation only brings
> some troubles.
> 
> In short,I think it's open to question whether the security of the
> system depends on the user's complete correct configuration(the system
> does not prohibit the export of a subdirectory).

I'd love to replace the export interface by one that prohibited
subdirectory exports (or at least made it more obvious where they're
being used.)

But given the interface we already have, that would be a disruptive and
time-consuming change.

Another approach is to add more entropy to filehandles so they're harder
to guess; see e.g.:

	https://www.fsl.cs.stonybrook.edu/docs/nfscrack-tr/index.html

In the end none of these change the fact that a filehandle has an
infinite lifetime, so once it's leaked, there's nothing you can do.  The
authors suggest NFSv4 volatile filehandles as a solution to that
problem, but I don't think they've thought through the obstacles to
making volatile filehandles work.

--b.
