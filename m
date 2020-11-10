Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D09002ADA79
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Nov 2020 16:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730368AbgKJPgB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Nov 2020 10:36:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730345AbgKJPgB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Nov 2020 10:36:01 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E630C0613CF
        for <linux-nfs@vger.kernel.org>; Tue, 10 Nov 2020 07:36:01 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id i13so5690270pgm.9
        for <linux-nfs@vger.kernel.org>; Tue, 10 Nov 2020 07:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Y3OxEabtaYQN31bepM6A0UjxA4BpcjK+RYy05f7C0f0=;
        b=iZQmE6IR5Ano+jYIGQRGncfEKz9m4Nf55h7CRI7X9ztYQ2wvnPo57MTD4qfdGXzf/y
         woRzsa0RZg/E6rZEExSqKzvLs3m+Z6MoRxF+v9Dm55s33LCSf8LdIJ0hdCYfpDZJjjCh
         J+L9wqzljiHUj08N2cnJp3W0QV6H3e3w0dKdryYNl8fnRPui3CSBa8PsdP6h66k17eYx
         Be2YMmU2Vm5DxCaAviCq/BZmaQHYDHy98w0CxqYTmtX7/5A9rhFQ8TxhSUopqyWB3dfu
         zAasn2MmqHKDXqHXypRp+PA7s6nmIwabVIfLCti5IdeWZy8LtuHJ44FH0MFt+jDdGy8s
         +i/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Y3OxEabtaYQN31bepM6A0UjxA4BpcjK+RYy05f7C0f0=;
        b=F59zSxqqYUl/54M99dEsgJ55lfnNOS+UfAn6CqQBhWZ6dKmb4uc9UORsgYHNas7n7e
         Kci0g5n2i6dU/pWEnWHwFVc0MZcRKWupTNr6VaorAlWEjGxVBkryo5DEqq+q2GGxtuTG
         MkQPu/lEL7vcaYFnLVpLTRyd16vkhjIuPxLYkroWHxC+DlfNpvuDl7NrWWsFq6MbVktS
         RJqF3+UpSK1Uw3zmwv27C00EWHs4x4A/Ur0EEoqeNr7rOC7BI74lPr8ZHFG5y14DinrM
         NQCwt0hQLk9swUawt6HskRZuz+gjHFBMjkgDUbKlPphf3fiksFRjjmYEaNrxvEvcn1SO
         /TZg==
X-Gm-Message-State: AOAM530zf+MZ7ezPoZBtO3X9dsaTS1uuWlPV2TBWbV21a61WvkyYIev3
        eHf1rs3VmSwTzeYKEoz2qMrBgL/l/rSdrs40U3Q=
X-Google-Smtp-Source: ABdhPJx3qaaJQQqzUUr0oEWjjlMyuEMKF/jmmplaiZEpklJ8fueWa0bmv2LJAxx/NASw+VH2cEX1+59qg6Si67/CWTQ=
X-Received: by 2002:a63:f318:: with SMTP id l24mr16996941pgh.193.1605022560917;
 Tue, 10 Nov 2020 07:36:00 -0800 (PST)
MIME-Version: 1.0
References: <CAN-5tyFAc0R=D0OL2WHkKacTMW0JxKmLoqv2A2Et2gg5G6gjtQ@mail.gmail.com>
 <C7C9450B-5782-4F1D-9F32-86D8B31820A0@gmail.com> <CADaq8jd=hKm7omSa26EN7R6nbsifpsmJHkBxixMYuH1M_4nb=w@mail.gmail.com>
In-Reply-To: <CADaq8jd=hKm7omSa26EN7R6nbsifpsmJHkBxixMYuH1M_4nb=w@mail.gmail.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Tue, 10 Nov 2020 10:35:50 -0500
Message-ID: <CAN-5tyFXsHeNjryYGk=sDWwXMjMznPeNYsGGnbTUPK_MYaPgxg@mail.gmail.com>
Subject: Re: [nfsv4] question about labeled NFS+rfc7569+selinux
To:     David Noveck <davenoveck@gmail.com>
Cc:     Thomas Haynes <loghyr@gmail.com>,
        "earsh@netapp.com" <earsh@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>, NFSv4 <nfsv4@ietf.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Tom, David, thank you for the comments. Thank you for confirmation
that Selinux is misbehaving. I think it's unlikely we can fix the
Selinux. I'm not sure if this is Selinux's "default" label format
number and if another label would use a different number. I actually
hope not, I hope they consistently choose 0 for the format. Otherwise,
I think it would be impossible for the server to create a "default"
label for a file that was created by another non-MAC-aware client. I
think in this case, the server would need to determine/know that this
volume has Selinux formatted for their files and create a default
Selinux label.

On Fri, Nov 6, 2020 at 5:17 AM David Noveck <davenoveck@gmail.com> wrote:
>
>
>
> On Friday, November 6, 2020, Thomas Haynes <loghyr@gmail.com> wrote:
>>
>>
>>
>> > On Nov 5, 2020, at 11:47 AM, Olga Kornievskaia <aglo@umich.edu> wrote:
>> >
>> > Hi folks,
>> >
>> > I would like to know if somebody can comment on the following
>> > regarding labeled NFS.
>
>
> I can comment but "oh, gee. What a godamn mess!" Is probably not what you=
 are looking for.
>
>>
>> >
>> > RFC 7569 talks about Label formats and specifically lists that "0" is
>> > a reserved value.
>> >
>> > Using labeled NFS with SElinux and looking at labels (in wireshark),
>> > the selinux sends sends/sets label format as 0 (ie. this is a reserved
>> > value according to the spec)
>> >
>> > So we have labelformat_spec4 set to 0 where the spec says this field
>> > "The LFS and the Security Label Format Selection Registry are
>> > described in detail in [RFC7569]". It's unlikely that  "0" reserved
>> > for Selinux and not explicitly specified there?
>> >
>> > 0 seems to be a good choice for using as a default label which the
>> > RFC7862 vaguely talks about (though says nothing about the format for
>> > a default label).
>
>
> Does Selinux use 0 as the  selector only for default labels, or does it u=
se it for other, non-default labels?. I'm assuming default labels would jus=
t consist of the zero selector and nothing else.
>>
>> >
>> > I'm not aware if Selinux is supposed to follow a spec and
>
>
> We'll it is said to support the labeled NFS feature and that probably mea=
ns it makes at least some attempt to follow the relevant specs.
>>
>>
>> therefore I
>> > don't think it is obligated to follow the rules of RFC 7569.
>
>
> The IETF has no enforcement powers.
>>
>>
>> Anybody
>> > can comment how labeled NFS label format and SElinux label format
>> > choice are supposed to co-exist?
>
>
> I guess it wasn't really thought about.
>
> They have co-existed so far by  others staying away from zero and by Seli=
nux using nothing else.
>>
>> >
>> > Thank you.
>>
>> Hi Olga,
>>
>> The SELinux implementation of Labeled NFS is not spec compliant.
>
>
> Good to know.
>
>>
>>
>> There are two paths forward:
>
>
> I think both of them run into difficulties.
>>
>>
>> 1) Fix the implementation to be spec compliant.
>
>
> Not sure how that would be done or who would do it. Even apart from compa=
tibility issues with the legacy non-compliant implementation, this is non-t=
rivial.
> ..
>
>> 2) File an errata to RFC 7569 to allow 0 to be assigned to the SELinux i=
mplementation.
>
>
> That errata report would have to be rejected as it revises an existing wo=
rking group consensus.  The alternative would be a new working group consen=
sus with an RFC updating or obsoleting RFC 7569.   There is nobody to do th=
at work and I'm pretty sure we'd run into the issue we ran into with integr=
ity measurement in which getting a specification for a piece of Linux imple=
mentation becomes a difficult and thankless task.
>
> I think we will just leave this as it is.  A new security document  would=
 have to mention it but  only to say this is a troubled area that will even=
tually need working group. Attention.  Sigh!
>>
>>
>> The argument against 1) is that there are existing deployments of server=
s and clients which will be incompatible.
>
>
> One of many issues with this.
>>
>>
>> Thanks,
>> Tom
>> _______________________________________________
>> nfsv4 mailing list
>> nfsv4@ietf.org
>> https://www.ietf.org/mailman/listinfo/nfsv4
