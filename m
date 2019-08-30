Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD28A3EB0
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Aug 2019 21:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbfH3Tyo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 30 Aug 2019 15:54:44 -0400
Received: from fieldses.org ([173.255.197.46]:51296 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727979AbfH3Tyo (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 30 Aug 2019 15:54:44 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 011541CB4; Fri, 30 Aug 2019 15:54:44 -0400 (EDT)
Date:   Fri, 30 Aug 2019 15:54:43 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Alex Lyakas <alex@zadara.com>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org,
        Shyam Kaushik <shyam@zadara.com>
Subject: Re: [RFC-PATCH] nfsd: when unhashing openowners, increment
 openowner's refcount
Message-ID: <20190830195443.GC5053@fieldses.org>
References: <1566406146-7887-1-git-send-email-alex@zadara.com>
 <CAOcd+r0bXefi79dnwrwsDN1OecScfTjc8DYS5_9A8D5XKrh7QQ@mail.gmail.com>
 <20190826133951.GC22759@fieldses.org>
 <CAOcd+r059fh7J8T=6MdjPSCP39K5fpOZTsXZDUKq5TrPv_RcVQ@mail.gmail.com>
 <20190827205158.GB13198@fieldses.org>
 <CAOcd+r0Ybfr1WszjYc1K19Cf7JmKowy=Go6nc8Fexf5KxNyf=A@mail.gmail.com>
 <20190828165429.GC26284@fieldses.org>
 <CAOcd+r3e52q_ds3zjya98whYarqoXf5C2umNEX-AGp4-R6=Cuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOcd+r3e52q_ds3zjya98whYarqoXf5C2umNEX-AGp4-R6=Cuw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Aug 29, 2019 at 09:12:49PM +0300, Alex Lyakas wrote:
> Would moving this code into the "unlock_filesystem" infrastructure be
> acceptable? Since the "share_id" approach is very custom for our
> usage, what criteria would you suggest for selecting the openowners to
> be "forgotten"?

Have you looked at what unlock_filesystem()?  It's just translating the
given path to a superblock, then matching that against inodes in
nlmsvc_match_sb().

It's a little more complicated for nfs4_files since they don't have a
pointer to the inode. (Maybe it should.)  You can see how I get around
this in e.g.  fs/nfsd/nfs4state.c:nfs4_show_lock().

A superblock isn't the same thing as an export, thanks to bind mounts
and subdirectory exports.  But if the goal is to be able to unmount,
then a superblock is probably what you want.

--b.
