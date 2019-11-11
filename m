Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC037F77FD
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2019 16:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbfKKPqS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Nov 2019 10:46:18 -0500
Received: from mail-vk1-f173.google.com ([209.85.221.173]:44438 "EHLO
        mail-vk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbfKKPqR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Nov 2019 10:46:17 -0500
Received: by mail-vk1-f173.google.com with SMTP id o198so3606579vko.11
        for <linux-nfs@vger.kernel.org>; Mon, 11 Nov 2019 07:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IjxyUeJmfia7EAT5YbQDeM+fqVaTpibwfUgtYJe3GVY=;
        b=fVPtPEvvV8JxQkoZwbuzLlzp54TRMEzzh1y/HzKVricTjkW+03lOOkK5v5444gkH9Y
         XDUGUvhXCrIc8rq+chwcTav+kLVILFDRMpA7EWnEZ0/gx0x7fqn8Z+STD9Zcjl1CT64t
         HjYiR9lsKQxC722M9APtvB8Nv5s1v30MbvGVBd0Vluu6tG51/9xy82yRXxPyBhySEfcx
         oal5QJ9+EojMYZ3RJNdqNNp18NVLHK4xrudEvmN13qECxTkOKCRqeB09AsGuhjy6itL7
         UvsHyU/FTBecVkJZAX1cgQcSJi4jWPaqS0PjOoisBEFeMvVtdOq6bhFxPg6iN87twUrA
         qQPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IjxyUeJmfia7EAT5YbQDeM+fqVaTpibwfUgtYJe3GVY=;
        b=R5aYf+HSw8ll4+1yZko0T3DLnIt/HUyN4io7bjsI5Odi+ydbyoCM42N/fPtjzbfQ63
         1m8gUh0XmTqafS72N23MShcfmqh2FEV63Cjo2WiLkn7zGbstnPsBeJzAD/0u1X1c0Njs
         X9RO+TrmZu2djqYZCV7ui4YXwG4VMlw0IbjZqi1azObFaDSAa0ARaNhJ4fS0E1TxN7Yj
         2baHUESFKha3mpgpDbsX3kIsg4d+JFEtm+9CPp2jkxUPuFwSj2h3o2qkGqC4ooJ5I1jy
         KgiiD64Wl9MjB5ET5M4M5iLJxRkv8l7aIuYuJhWLBqfe/khryHNYPvCt+NXg0zwi8pd7
         hqjQ==
X-Gm-Message-State: APjAAAVz+Pa0oiIRz3jKE+MuJhqtaz+4g7xW/X5y6UQYYG2HeB4Xto6L
        9SeLTTy7OtXg/dm/1FpW8fYME/7zg8cki4kakXMnUGkj
X-Google-Smtp-Source: APXvYqz1rOe6pFqgfCFIsLE4i9/RcQZsyTTXF96oLiCa5O8apyD9O8P3g6Jj4O6R9ZI/ED31vU9miQoeSITX4a5+4j0=
X-Received: by 2002:ac5:cc71:: with SMTP id w17mr18651650vkm.58.1573487176516;
 Mon, 11 Nov 2019 07:46:16 -0800 (PST)
MIME-Version: 1.0
References: <3447df77-1b2f-6d36-0516-3ae7267ab509@genome.arizona.edu>
 <20191023171523.GA18802@fieldses.org> <b6248a82-1f1a-7329-5ee0-6e026f6db697@genome.arizona.edu>
 <YTBPR01MB2845B12E9C59F837FE35F40DDD650@YTBPR01MB2845.CANPRD01.PROD.OUTLOOK.COM>
 <82ee292f-f126-9e9f-d023-deb72d1a3971@genome.arizona.edu> <1079a074-7580-e257-8b52-6e48f8822176@genome.arizona.edu>
 <CAN-5tyExtO_HRGYrqq7UTObrHNsTp7UqwW=Kg4CFM3q-OnaUiQ@mail.gmail.com> <49472814-8dcd-4594-d48e-be4c1d9a8d8f@genome.arizona.edu>
In-Reply-To: <49472814-8dcd-4594-d48e-be4c1d9a8d8f@genome.arizona.edu>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Mon, 11 Nov 2019 10:46:05 -0500
Message-ID: <CAN-5tyGD3hNcG7=+xdB4Bs1OCCUoLzZ5ocsJusuxd3n3+x=7gw@mail.gmail.com>
Subject: Re: NFS hangs on one interface
To:     Chandler <admin@genome.arizona.edu>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Chandler,

Given what you say, it sounds to me more like a generic networking
issue between this particular problem and the server.

debug messages are logging that client can't reach the server:
Nov  8 17:58:21 NFSclient kernel: nfs: server x.2 not responding, still try=
ing

I'd recommend making sure that your network works alright between
those interfaces. Perhaps running an iperf for a few minutes to make
sure you are seeing expected, consistent performance between those two
nodes. Another thing to check if you for some reason have duplicate
IPs in the system that can show up as weird hangs.

On Fri, Nov 8, 2019 at 8:22 PM Chandler <admin@genome.arizona.edu> wrote:
>
> Hi Olga, thanks so much for your help.
>
> I tried to reboot and still having weird issues.  If I mount over the loc=
al network (10.x address) then there are no issues.  As soon as I try to mo=
unt over the 10G network, weird things happen.  For example, I can perform =
the mount just fine and do "ll /mount" but as soon as I try another directo=
ry like "ll /mount/users" then it hangs.  Also this only happens between th=
ese two machines with 10G interfaces.  The server with the 10G interface ha=
s several other 1G clients that outside the local 10.x network that connect=
 to it on the 10G interface, and those clients all work fine as well, so se=
ems to be an issue specific to this client on the 10G interface.
>
> In my earlier post, I did try troubleshooting with vers=3D3 and vers=3D2 =
just to see if that was the issue, but since then have been using the defau=
lts (so vers=3D4).
>
> I turned on the rpcdebug on both client and server with "rpcdebug -m nfs(=
d) all"  but it seemed to lock up the server and i had to reboot it, so wil=
l keep that off for now.  I attached a log of the debug messages from the c=
lient showing what commands I executed (snoopy) and the resulting kernel de=
bug entries, hope this helps.  The hangup happens at the end when I ls -l o=
n the users directory.  Let me know if there's anything else I can provide.
>
