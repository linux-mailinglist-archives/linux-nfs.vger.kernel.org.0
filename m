Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 276002130EE
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Jul 2020 03:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgGCBUn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 2 Jul 2020 21:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgGCBUm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 2 Jul 2020 21:20:42 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F57C08C5C1
        for <linux-nfs@vger.kernel.org>; Thu,  2 Jul 2020 18:20:42 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id o10so5319589uab.10
        for <linux-nfs@vger.kernel.org>; Thu, 02 Jul 2020 18:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gAj81iZbIYdOoXwDhlu34xHNUG5ce9BG/8X4yyc57oA=;
        b=ClvQE339sB4YofhxbpGu1CFLDYuEGD/Fp8ETYoSfe3LFgUCDFU/Gh7oZJMymmPm8XY
         W3bBTB7igUNTbRVBeimlLHl4Nwe3bAoRCd+4NlqS4hwt3Qoi9btm8QIqunTNWSSN3r35
         OkdXJlcMRypkyskKvWk2rZWYIAtnlD61oHNt9/ZcSQk03emt0L61rloco8EPPpyEZ8Do
         VhdAmor7yLYlA3+b7jWLOfH/d8SqT/t6q1ZOvmno+x3xyjZ9iLK8zkRdCxNWhqhXbnhD
         IQxwm6HL2CD74POAnJUTawFy2ebvjCeCQq9aAPxDw+T3n4qmp8+TcRWlWlHBlWTFwtpf
         keaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gAj81iZbIYdOoXwDhlu34xHNUG5ce9BG/8X4yyc57oA=;
        b=f/I0VQMrAT1MyT3s32SZf5GUPvZdbgGoPPALm4AV5mjKqt6xsJAjrkbLmb6+yD520W
         oEzE+2HYnGBBZOnG4gLgnIWMl5HGWJTWgvkrS4F8bUhB1trxCXNTdW6R2WcWstnWIPfx
         UJZA0DW2VXk8gkqb4LxPW37wuFC08XgRx+QAbsxdVPlJkQIZWnE8yb9ELldwLbe9Rrel
         cJdYq/Sne0UP9dYhSIfyfuaAPLuNDTz5GY6c61zXK/Ichytmy/ZdetqTtsrQTOgExX6B
         w+UvJ5z4/gXM7DD11ZIBBgU98e81AXXevimlnnxE67gbeBSLfjhKeiktZ/5QqcRLjXjk
         AEkQ==
X-Gm-Message-State: AOAM530zINY6xWbUmHBkjdApZ3CYkS0z2ezGLuYwNyX6i3H9f068f5GO
        PyFBib+MWVgAdbwQB2yyWavR7tkzVyfgWeN6QakAxiPR
X-Google-Smtp-Source: ABdhPJxPvw3gOXCiA2PZ5au1IcPKK7j2apwYXfvXu4mBw5yUwfvhsqppsYzJuPVTpQArUwXUIwncrql6ECe1GUC/VwQ=
X-Received: by 2002:ab0:48:: with SMTP id 66mr11491766uai.40.1593739241673;
 Thu, 02 Jul 2020 18:20:41 -0700 (PDT)
MIME-Version: 1.0
References: <3c399c3523674ec7b650b647179d7c96@tu-berlin.de>
In-Reply-To: <3c399c3523674ec7b650b647179d7c96@tu-berlin.de>
From:   Nico Kadel-Garcia <nkadel@gmail.com>
Date:   Thu, 2 Jul 2020 21:20:28 -0400
Message-ID: <CAOCN9rz8m1Z75ObhC21V=jizPnEkfFaZv-1Yz4M5zsT19BR97g@mail.gmail.com>
Subject: Re: [Samba] Multiprotocol File Sharing via NFSv4 and Samba
To:     "Kraus, Sebastian" <sebastian.kraus@tu-berlin.de>
Cc:     "samba@lists.samba.org" <samba@lists.samba.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jul 2, 2020 at 2:16 PM Kraus, Sebastian via samba
<samba@lists.samba.org> wrote:
>
> Hi all,
> are there any non-commercial solutions (apart from solutions like Dell EM=
C, IBM and NetApp) around that allow to simultaneously access the same file=
 system via NFSv4 and Samba exports in a (nearly) non-conflicting manner, e=
specially w.r.t. to NFSv4/Windows ACL incompatibilities?
>
> Best
> Sebatian

I've done it at a commercial scale with locally configured NFS on
Linux clients and Samba for CIFS access on windows clients. It's very
tricky to scale, and to maintain consistent privileges. NFSv4 map
somewhat, but not *perfectly* to CIFS credentials. And lock files
become an adventure, because clients *cannot* be entirely in sync with
a centralized server, the constant monitoring and updating to be in
tight4er and tighter sync themselves cost bandwidth and CPU. So
collaboration working with the same files can require thoughtful
programming to ensure atomic operation. I don't recommend it: I'd
generally recommend picking one protocol or the other and using it
everywhere. It's extraordinarily difficult to predict
incompatibilities someone may run into with ocmmercial software,
written to use lock files with *very* peculiar behavior. And of course
there is the filesystem namespace collission issue. In NFS, README.md"
is a different file from README.MD or readme.md, and resolving this
with CIFS clients o the same workspace can be an adventure.

There are many inexpensive office grade petabyte storage servers which
rely on Samba internally and would probably serve your needs.
