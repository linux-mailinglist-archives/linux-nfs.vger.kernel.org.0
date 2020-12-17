Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF492DD369
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Dec 2020 15:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgLQO62 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Dec 2020 09:58:28 -0500
Received: from elasmtp-kukur.atl.sa.earthlink.net ([209.86.89.65]:46288 "EHLO
        elasmtp-kukur.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727769AbgLQO61 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Dec 2020 09:58:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mindspring.com;
        s=dk12062016; t=1608217107; bh=Inxo2ECnVZrBeZLCHxpNnsIiI8OZ/+5mZ73Z
        bMhFzh0=; h=Received:From:To:References:In-Reply-To:Subject:Date:
         Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
         X-Mailer:Content-Language:Thread-Index:X-ELNK-Trace:
         X-Originating-IP; b=C2b6xHSCZiei+qggiWGjs8J1mXSv2jrz9AwcQ32Rt/hPGk
        5p0WQh5gO52du8HR3UhI8fK3LsJbKGAWW2A4uHeBOQ/93rZJQL5Y4s1SRc0xGCGe2pA
        q7r3URYymcG9yURG0YhrRrerFop14Z1lXGAUwZDMCh0X/I/Cr3m4DxWMdvEu2EXmhuD
        w/JipEN/IujqWR6J/AErPXZEya9cIHMxJROoSeT3XSRwn1DXlhegoEhignmdfo82s1q
        qyQJEzUZykNfqFTZaVZ52fnMpZ3WW02xtvQEVFdlDXjkLOR7jU12gumnJ3jXIcJtSds
        rpBhZ0EYTZBBaJ+o3P6t5m/1448w==
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=dk12062016; d=mindspring.com;
  b=CjyRyxyitvZKlEZT06K0OB0brpgx6TTo/AW6CC5icFtA2q9/FkkLvYtQfTdhabhQKY/zbc6mN8P69MKGbyCP2j7rNV/ML3KIs9+kgfE7qfIWzk9EuPRlvsxor26qXIFW3vdWp6uwpmUoUziZCTo0UkSS0AWE8ax48KSksJUt5A3uDZAOwBDsCcA79FzUFzTXK/3ZJgz+T/rBpq56F6JIR4KsJGlFLxYW+xmkbR9VwmM3upnhV3Ob7SGoFHNmqODROdJrDw05IiVnX7annD+tIqu81QczYkJ8AJr42bki1diDjF+It8k3Sh6N1mIbyJh4UP3OoWcIgXd3LYgKWidsLQ==;
  h=Received:From:To:References:In-Reply-To:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:Content-Language:Thread-Index:X-ELNK-Trace:X-Originating-IP;
Received: from [76.105.143.216] (helo=FRANKSTHINKPAD)
        by elasmtp-kukur.atl.sa.earthlink.net with esmtpa (Exim 4)
        (envelope-from <ffilzlnx@mindspring.com>)
        id 1kpuiw-00053m-Ji; Thu, 17 Dec 2020 09:57:46 -0500
From:   "Frank Filz" <ffilzlnx@mindspring.com>
To:     "'Suresh Jayaraman'" <sjayaraman@tintri.com>,
        <linux-nfs@vger.kernel.org>
References: <BY5PR11MB4152DF20ADAAC8F694C80AF1B8C40@BY5PR11MB4152.namprd11.prod.outlook.com>
In-Reply-To: <BY5PR11MB4152DF20ADAAC8F694C80AF1B8C40@BY5PR11MB4152.namprd11.prod.outlook.com>
Subject: RE: NFSv4x share reservations support
Date:   Thu, 17 Dec 2020 06:57:46 -0800
Message-ID: <034401d6d484$fb408710$f1c19530$@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Content-Language: en-us
Thread-Index: AQKpveR4sxqLTOYksrFzWeTTlRkNcKhVjDOQ
X-ELNK-Trace: 136157f01908a8929c7f779228e2f6aeda0071232e20db4d0cad08f40a69f903a2e973319cd3f5a0350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 76.105.143.216
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

> Does Linux NFS server disallow OPENs from SMB or local filesystem when a
> DENY_READ/DENY_WRITE (share reservation) is set on a file? If so, how is
it
> implemented (with VFS flags)?
> 
> The packet captures show that the Linux NFS4x clients always OPEN with
> DENY_NONE (as there is no POSIX support for DENY_READ/DENY_WRITE).
> Looked at https://linux-
> nfs.org/wiki/index.php/Cluster_Coherent_NFSv4_and_Share_Reservations but
> was not sure if it uptodate.
> 
> Would like to understand what level of share reservations support is
present in
> Linux NFS server today.

Since the Linux vfs layer has no way to represent deny modes, there is no
way for a Linux remote file system such as knfsd or Samba to coordinate on
deny reservations. There was a patch set years ago that would have added
deny modes to the Linux open system call, but it never got enough support to
be merged.

The only way to accomplish this is to either have a file system that
implements deny modes with some kind of out of band means for applications
and servers to communicate (such as an fcntl call) or for remote file system
servers to coordinate in the background. There are proprietary out of tree
file systems that provide this coordination, but nothing in tree to my
knowledge (if there is, please let me know, nfs-ganesha COULD utilize such
an out of band mechanism).

Frank

