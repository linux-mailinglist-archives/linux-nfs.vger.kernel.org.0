Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 917D0288A4E
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Oct 2020 16:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732366AbgJIOIB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 9 Oct 2020 10:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbgJIOIB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 9 Oct 2020 10:08:01 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E14C0613D2;
        Fri,  9 Oct 2020 07:08:00 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id d1so7991893qtr.6;
        Fri, 09 Oct 2020 07:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=kBW+4/PqHA8W886GKDVa8HW7sWoRETpTXRD9CWylw7w=;
        b=XEh+GF3VLggR+3Z70dprxCVK427MftxDZlG4W1ns+/FPhaZOUcuZg6fcgPh+ELVR76
         5pOF1al6o3/YuOUX2rEgnD3TuBQNGGE1QMxJ+iL8u0AxN5Dq8MvZIPUneJp0JgdVx4me
         ylxXm0TCMPxMu3+OgbJH9hxURTEPVX9r/BYkk4leciuzSmGYbEL2FtnMJZLt8kpeky7E
         IRURr4a8J9Vd9+ZewYyZlWC9Wdk2Rzw5KFt3ir/xXP+pOmJrY5p1/vbVim8t6h8lw0kL
         yjE7jVavc+uzUuBMb9i9CCco6x0DBbC+O4qN5v81jTZ/ytvVLpl7mLcBMQmV85vBAdZW
         EJsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=kBW+4/PqHA8W886GKDVa8HW7sWoRETpTXRD9CWylw7w=;
        b=YqHbVmKIrnWODqnTzH80Fk3TFjRVRaCZH7GiigqjvrCTMBESK9rD2KVo6FmrohIXnT
         FTofLu/rX/zcaRTljRDuGDwqupC4bca166P7h1vXdJJX3iongNxdddHYbZJ+fajlupAB
         87/euKOfkX0Ezvtez9UZNxahdbkpfgw7GId82CDFpaLxLtSEtw21MvD6zuWugG+JbQwt
         /GXxPy2WbYr/t0l+61MtssT9PWtaMLibmpvy+UERH6CgzkBeMPxU/tmdpkxyvyP6iisy
         K+NIKJQxhOYzsaPItnezSf175lTxiT1taQG8DgXilC3M3Aof9JBB8ZKqsvsZld3JZkxj
         p26g==
X-Gm-Message-State: AOAM5303Q9jSMQX0pW3JPgdXJMUrNCr6WTdFEWYv/70AuU8q+iHoXc7W
        TxApHSF+lageK+CYLbo/TVk=
X-Google-Smtp-Source: ABdhPJyI6hs+9GtMY/g89hQoT90TRhqpsUwACfPW04Hu9dRqUJRPM1mgpQDrqHGE1994Am0g0SwsKA==
X-Received: by 2002:ac8:d8d:: with SMTP id s13mr12976833qti.42.1602252480141;
        Fri, 09 Oct 2020 07:08:00 -0700 (PDT)
Received: from anon-dhcp-152.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id x22sm3240540qki.104.2020.10.09.07.07.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Oct 2020 07:07:59 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: selinux: how to query if selinux is enabled
From:   Chuck Lever <chucklever@gmail.com>
In-Reply-To: <CAN-5tyGJxUZb5QdJ=fh+L-6rc2B-MhQbDcDkTZNAZAAJm9Q8YQ@mail.gmail.com>
Date:   Fri, 9 Oct 2020 10:07:58 -0400
Cc:     Paul Moore <paul@paul-moore.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <FB6C74CE-5D9F-4469-A49B-93CC8A51D7D5@gmail.com>
References: <CAN-5tyETQWVphrgqWjcPrtTzHHyz5DGrRz741yPYRS9Byyd=3Q@mail.gmail.com>
 <CAHC9VhRP2iJqLWiBg46zPKUqxzZoUOuaA6FPigxOw7qubophdw@mail.gmail.com>
 <CAN-5tyFq775PeOOzqskFexdbCgK3Gk_XB2Yy80SRYSc7Pdj=CA@mail.gmail.com>
 <CAHC9VhTzO1z6NmYz6cOLg5OvJiyQXdH_VmLh4=+h1MrGXx36JQ@mail.gmail.com>
 <CAN-5tyGJxUZb5QdJ=fh+L-6rc2B-MhQbDcDkTZNAZAAJm9Q8YQ@mail.gmail.com>
To:     Olga Kornievskaia <aglo@umich.edu>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 9, 2020, at 7:49 AM, Olga Kornievskaia <aglo@umich.edu> wrote:
> 
> On Thu, Oct 8, 2020 at 9:03 PM Paul Moore <paul@paul-moore.com> wrote:
>> 
>> ->On Thu, Oct 8, 2020 at 9:50 AM Olga Kornievskaia <aglo@umich.edu> wrote:
>>> On Wed, Oct 7, 2020 at 9:07 PM Paul Moore <paul@paul-moore.com> wrote:
>>>> On Wed, Oct 7, 2020 at 8:41 PM Olga Kornievskaia <aglo@umich.edu> wrote:
>>>>> Hi folks,
>>>>> 
>>>>> From some linux kernel module, is it possible to query and find out
>>>>> whether or not selinux is currently enabled or not?
>>>>> 
>>>>> Thank you.
>>>> 
>>>> [NOTE: CC'ing the SELinux list as it's probably a bit more relevant
>>>> that the LSM list]
>>>> 
>>>> In general most parts of the kernel shouldn't need to worry about what
>>>> LSMs are active and/or enabled; the simply interact with the LSM(s)
>>>> via the interfaces defined in include/linux/security.h (there are some
>>>> helpful comments in include/linux/lsm_hooks.h).  Can you elaborate a
>>>> bit more on what you are trying to accomplish?
>>> 
>>> Hi Paul,
>>> 
>>> Thank you for the response. What I'm trying to accomplish is the
>>> following. Within a file system (NFS), typically any queries for
>>> security labels are triggered by the SElinux (or I guess an LSM in
>>> general) (thru the xattr_handler hooks). However, when the VFS is
>>> calling to get directory entries NFS will always get the labels
>>> (baring server not supporting it). However this is useless and affects
>>> performance (ie., this makes servers do extra work  and adds to the
>>> network traffic) when selinux is disabled. It would be useful if NFS
>>> can check if there is anything that requires those labels, if SElinux
>>> is enabled or disabled.
>> 
>> [Adding Chuck Lever to the CC line as I believe he has the most recent
>> LSM experience from the NFS side - sorry Chuck :)]
>> 
>> I'll need to ask your patience on this as I am far from a NFS expert.
>> 
>> Looking through the NFS readdir/getdents code this evening, I was
>> wondering if the solution in the readdir case is to simply tell the
>> server you are not interested in the security label by masking out
>> FATTR4_WORD2_SECURITY_LABEL in the nfs4_readdir_arg->bitmask in
>> _nfs4_proc_readdir()?  Of course this assumes that the security label
>> genuinely isn't needed in this case (and not requesting it doesn't
>> bypass access controls or break something on the server side), and we
>> don't screw up some NFS client side cache by *not* fetching the
>> security label attribute.
>> 
>> Is this remotely close to workable, or am I missing something fundamental?
>> 
> 
> No this is not going to work, as NFS requires labels when labels are
> indeed needed by the LSM. What I'm looking for is an optimization.
> What we have is functionality correct but performance might suffer for
> the standard case of NFSv4.2 seclabel enabled server and clients that
> don't care about seclabels.

Initial thought: We should ask linux-nfs for help with this.
I've added them to the Cc: list.

Olga, are you asking if the kernel NFS client module can somehow find
out whether the rest of the kernel is configured to care about security
labels before it forms an NFSv4 READDIR or LOOKUP request?

I would certainly like to take the security label query out of every
LOOKUP operation if that is feasible!


--
Chuck Lever
chucklever@gmail.com



