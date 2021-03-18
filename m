Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C32F8341082
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Mar 2021 23:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbhCRWwF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 18 Mar 2021 18:52:05 -0400
Received: from namei.org ([65.99.196.166]:45956 "EHLO mail.namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230368AbhCRWvr (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 18 Mar 2021 18:51:47 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.namei.org (Postfix) with ESMTPS id 9E1ACC6B;
        Thu, 18 Mar 2021 22:49:03 +0000 (UTC)
Date:   Fri, 19 Mar 2021 09:49:03 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Paul Moore <paul@paul-moore.com>
cc:     Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>
Subject: Re: [PATCH v4 1/3] [security] Add new hook to compare new mount to
 an existing mount
In-Reply-To: <CAHC9VhQyck5HKGKBcv-q70fv6zwTHD2hdfJ3e3SnjqoVty6inA@mail.gmail.com>
Message-ID: <1e3cd4d7-2a80-a5c1-b5cd-919bfb1e493@namei.org>
References: <CAN-5tyGuV-gs0KzVbKSj42ZMx553zy9wOfVb1SoHoE-WCoN1_w@mail.gmail.com> <20210227033755.24460-1-olga.kornievskaia@gmail.com> <CAFX2Jfk--KwkAss1gqTPnQt-bKvUUapNdHbuicu=m+jOtjrMyQ@mail.gmail.com> <f8f5323c-cdfd-92e8-b359-43caaf9d7490@schaufler-ca.com>
 <CAHC9VhR=+uwN8U17JhYWKcXSc9=ExCrG4O9-y+DPJg6xZ=WoYA@mail.gmail.com> <CAFX2JfnT49o-CkaAE3=c0KW9SDS1U+scP0RD++nmWwyKoBDWkA@mail.gmail.com> <CAHC9VhQNp-GQ6SMABNdN00RcDz30Os5SK217W-5swS8quakxPA@mail.gmail.com> <CAN-5tyG95bL8vbkG5B9OmAAXremJ-X5z09f+0ekLyigzibsZ5A@mail.gmail.com>
 <CAHC9VhTwqt0TDEWV97GaM8B5m4qmEwo+BYXYDeMs2D1LtZzUFg@mail.gmail.com> <CAN-5tyHdiuiOBX2bkZBGOTK-AMOccm27=qE-AZ_J9QQ00P91-Q@mail.gmail.com> <CAHC9VhTZe0azgqt_OSk0cy-nM+upz9z2_i0j1wQQLD8UgbX9+Q@mail.gmail.com>
 <CAHC9VhQyck5HKGKBcv-q70fv6zwTHD2hdfJ3e3SnjqoVty6inA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 18 Mar 2021, Paul Moore wrote:

> On Mon, Mar 15, 2021 at 12:15 PM Paul Moore <paul@paul-moore.com> wrote:
> > As long as we are clear that the latest draft of patch 1/3 is to be
> > taken from the v4 patch{set} and patches 2/3 and 3/3 are to be taken
> > from v3 of the patchset I don't think you need to do anything further.
> > The important bit is for the other LSM folks to ACK the new hook; if I
> > don't see anything from them, either positive or negative, I'll merge
> > it towards the end of this week or early next.
> 
> LSM folks, this is a reminder that if you want to object you've got
> until Monday morning to do so :)

I'm unclear on whether a new v5 patchset was being posted -- I assume not?

-- 
James Morris
<jmorris@namei.org>

