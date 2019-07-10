Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4249463E8A
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jul 2019 02:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfGJAI4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 9 Jul 2019 20:08:56 -0400
Received: from fieldses.org ([173.255.197.46]:52820 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbfGJAI4 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 9 Jul 2019 20:08:56 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id C1CBD1BE7; Tue,  9 Jul 2019 20:08:55 -0400 (EDT)
Date:   Tue, 9 Jul 2019 20:08:55 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Su Yanjun <suyj.fnst@cn.fujitsu.com>
Cc:     linux-nfs@vger.kernel.org, dang@redhat.com, ffilzlnx@mindspring.com
Subject: Re: [Problem]testOpenUpgradeLock test failed in nfsv4.0 in 5.2.0-rc7
Message-ID: <20190710000855.GE1536@fieldses.org>
References: <a4ff6e56-09d6-1943-8d71-91eaa418bd1e@cn.fujitsu.com>
 <f105f5a8-d38f-a58a-38d1-6b7a4df4dc9d@cn.fujitsu.com>
 <89d5612e-9af6-8f2e-15d8-ff6af29d508a@redhat.com>
 <016101d5359b$c71f06c0$555d1440$@mindspring.com>
 <4d6599c3-2280-e919-b60f-905f86452ac1@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4d6599c3-2280-e919-b60f-905f86452ac1@cn.fujitsu.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jul 09, 2019 at 01:27:31PM +0800, Su Yanjun wrote:
> Hi Bruce
> 
> 在 2019/7/8 22:45, Frank Filz 写道:
> >Yea, sorry, I totally missed this, but it does look like it's a Kernel nfsd
> Any suggestions?
> >issue.

I don't know.  I'd probably want to check a packet trace first to make
completely sure I understand what's happening on the wire.  It may be a
couple weeks before I get to this.

--b.

> >
> >Frank
> >
> >>-----Original Message-----
> >>From: Daniel Gryniewicz [mailto:dang@redhat.com]
> >>Sent: Monday, July 8, 2019 6:49 AM
> >>To: Su Yanjun <suyj.fnst@cn.fujitsu.com>; ffilzlnx@mindspring.com
> >>Cc: linux-nfs@vger.kernel.org
> >>Subject: Re: [Problem]testOpenUpgradeLock test failed in nfsv4.0 in
> >>5.2.0-rc7
> >>
> >>Is this running knfsd or Ganesha as the server?  If it's Ganesha, the
> >>question
> >>would be better asked on the Ganesha Devel list
> >>devel@lists.nfs-ganesha.org
> >>
> >>If it's knfsd, than Frank isn't the right person to ask.
> We are using the knfsd.
> >>
> >>Daniel
> >>
> >>On 7/7/19 10:20 PM, Su Yanjun wrote:
> >>>Ang ping?
> >>>
> >>>在 2019/7/3 9:34, Su Yanjun 写道:
> >>>>Hi Frank
> >>>>
> >>>>We tested the pynfs of NFSv4.0 on the latest version of the kernel
> >>>>(5.2.0-rc7).
> >>>>I encountered a problem while testing st_lock.testOpenUpgradeLock.
> >>>>The problem is now as follows:
> >>>>**************************************************
> >>>>LOCK24 st_lock.testOpenUpgradeLock : FAILURE
> >>>>            OP_LOCK should return NFS4_OK, instead got
> >>>>            NFS4ERR_BAD_SEQID
> >>>>**************************************************
> >>>>Is this normal?
> >>>>
> >>>>The case is as follows:
> >>>>Def testOpenUpgradeLock(t, env):
> >>>>     """Try open, lock, open, downgrade, close
> >>>>
> >>>>     FLAGS: all lock
> >>>>     CODE: LOCK24
> >>>>     """
> >>>>     c= env.c1
> >>>>     C.init_connection()
> >>>>     Os = open_sequence(c, t.code, lockowner="lockowner_LOCK24")
> >>>>     Os.open(OPEN4_SHARE_ACCESS_READ)
> >>>>     Os.lock(READ_LT)
> >>>>     Os.open(OPEN4_SHARE_ACCESS_WRITE)
> >>>>     Os.unlock()
> >>>>     Os.downgrade(OPEN4_SHARE_ACCESS_WRITE)
> >>>>     Os.lock(WRITE_LT)
> >>>>     Os.close()
> >>>>
> >>>>After investigation, there was an error in unlock->lock. When
> >>>>unlocking, the lockowner of the file was not released, causing an
> >>>>error when locking again.
> >>>>Will nfs4.0 support 1) open-> 2) lock-> 3) unlock-> 4) lock this
> >>>>function?
> >>>>
> >>>>
> >>>>
> >>>
> >
> >
> 
