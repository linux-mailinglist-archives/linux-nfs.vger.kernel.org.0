Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37CE92CC7C
	for <lists+linux-nfs@lfdr.de>; Tue, 28 May 2019 18:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbfE1Qrs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 May 2019 12:47:48 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40157 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfE1Qrs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 28 May 2019 12:47:48 -0400
Received: by mail-io1-f66.google.com with SMTP id n5so10164621ioc.7
        for <linux-nfs@vger.kernel.org>; Tue, 28 May 2019 09:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=y+cJGxrPWQXJyIDKrTn87Z3M+bbydnObzOQaz91mURI=;
        b=fFumxnxrWbeTqJVTexVM5nmGFfd8uQQSuAmLf4zIzGVA4+vrOi81u6hTofAfK+uVwp
         qhib288dkNGsCR2nVXgfLg1IuqKgBqfb03r2EWel/WeASXBYvBglrROWtuE3Sms6+b4U
         qXWBCySRJPR1hxzcE3RdVXn7HpWeNvYRSdZGwQKUlNQp4PI3tthQcfaLbFbW7c9pDg/8
         MCz+v4MTw180qfb/izf+xgG7Q+RLijqQn6a9eFYM98IfmN5lEKxFdf4866bjrQQhDdNk
         EN941X06W5XDgh4BPFI71KNhTDBp4+fF5YNrdJMnIieMb1+QyMmxGuDsDHTV9fOPODK3
         dbgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=y+cJGxrPWQXJyIDKrTn87Z3M+bbydnObzOQaz91mURI=;
        b=BgFRhBuCG40DXh8wPfg9YKFz41WptnzQtnjrAQ5tl6wvt9+2dEWDmHlD/50O9LdScm
         uK7m+GPHfntkh0pzQ50yhzOdIajP692hvHjwCDEXEMSejO5I+tolRBK47Hn9eroJaym2
         w06pC2XMM3NeE8spl51FWpvZKfMSA1QO1Y6b1UkJmxPhQFKbyMFQ325m41NjkxXP4k+m
         /nfOKk/N0QcqCsifJCyWpXfyyHnIin7jLRubGej//KpeHgIrqUiOmJN8vjWZvTNCk9in
         EHu4F3aFvsq8LAt2JAmKa/nflvtj+AUO7RazdaESE/jcIIWTjq0vOCsoooaoILTd/h5Y
         TEQw==
X-Gm-Message-State: APjAAAVQha2gPUbThYRSXxkdg1pPeGqsciY6CutoGEA7hNAmeYkcgQ9g
        TFzXrJP4ASk9pNrjkAnhpWX2kRG3
X-Google-Smtp-Source: APXvYqxsHSLtyCL+5vFwCmeusg2gooWyjNE1tSgpeFiacNdUjWcEJcdgLnL6g9JYWx/Ks6Lis0PG9g==
X-Received: by 2002:a6b:e711:: with SMTP id b17mr10061199ioh.3.1559062067054;
        Tue, 28 May 2019 09:47:47 -0700 (PDT)
Received: from anon-dhcp-171.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id j125sm1448330itb.27.2019.05.28.09.47.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 09:47:46 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [RFC PATCH v2 0/7] Add a root_dir option to nfs.conf
From:   Chuck Lever <chucklever@gmail.com>
In-Reply-To: <c7a5f97693c56ee0a7dd5a9c0848ee97ab3d2a9e.camel@hammerspace.com>
Date:   Tue, 28 May 2019 12:47:45 -0400
Cc:     Steve Dickson <SteveD@RedHat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F2801C3F-558A-4176-A0B0-ECD737D4332D@gmail.com>
References: <20190521124701.61849-1-trond.myklebust@hammerspace.com>
 <708D03B6-AEE1-42D6-ABDF-FB1AA5FC9A94@gmail.com>
 <25ce1d3aa852ecd09ff300233aea60b71e6e69df.camel@hammerspace.com>
 <1BB55244-E893-47A2-B4CB-36CA991A84B0@gmail.com>
 <501262c68530acbce21f39e0015e76805dedfe48.camel@hammerspace.com>
 <3503ff03-2895-ae1f-7fed-f30d08b0abfb@RedHat.com>
 <c7a5f97693c56ee0a7dd5a9c0848ee97ab3d2a9e.camel@hammerspace.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 28, 2019, at 12:44 PM, Trond Myklebust =
<trondmy@hammerspace.com> wrote:
>=20
> On Tue, 2019-05-28 at 11:25 -0400, Steve Dickson wrote:
>>=20
>> On 5/21/19 3:58 PM, Trond Myklebust wrote:
>>> On Tue, 2019-05-21 at 15:06 -0400, Chuck Lever wrote:
>>>>> On May 21, 2019, at 2:17 PM, Trond Myklebust <
>>>>> trondmy@hammerspace.com> wrote:
>>>>>=20
>>>>> On Tue, 2019-05-21 at 13:40 -0400, Chuck Lever wrote:
>>>>>> Hi Trond -
>>>>>>=20
>>>>>>> On May 21, 2019, at 8:46 AM, Trond Myklebust <
>>>>>>> trondmy@gmail.com
>>>>>>> wrote:
>>>>>>>=20
>>>>>>> The following patchset adds support for the 'root_dir'
>>>>>>> configuration
>>>>>>> option for nfsd in nfs.conf. If a user sets this option to
>>>>>>> a
>>>>>>> valid
>>>>>>> directory path, then nfsd will act as if it is confined to
>>>>>>> a
>>>>>>> chroot
>>>>>>> jail based on that directory. All paths in /etc/exporfs and
>>>>>>> from
>>>>>>> exportfs are then resolved relative to that directory.
>>>>>>=20
>>>>>> What about files under /proc that mountd might access? I
>>>>>> assume
>>>>>> these
>>>>>> pathnames are not affected.
>>>>>>=20
>>>>> That's why we have 2 threads. One thread is root jailed using
>>>>> chroot,
>>>>> and is used to talk to knfsd. The other thread is not root
>>>>> jailed
>>>>> (or
>>>>> at least not by root_dir) and so has full access to /etc,
>>>>> /proc,
>>>>> /var,
>>>>> ...
>>>>>=20
>>>>>> Aren't there also one or two other files that maintain export
>>>>>> state
>>>>>> like /var/lib/nfs/rmtab? Are those affected?
>>>>>=20
>>>>> See above. They are not affected.
>>>>>=20
>>>>>> IMHO it could be less confusing to administrators to make
>>>>>> root_dir an
>>>>>> [exportfs] option instead of a [mountd] option, if this is
>>>>>> not a
>>>>>> true
>>>>>> chroot of mountd.
>>>>>=20
>>>>> It is neither. I made in a [nfsd] option, since it governs the
>>>>> way
>>>>> that
>>>>> both exportfs and mountd talk to nfsd.
>>>>=20
>>>> My point is not about implementation, it's about how this
>>>> functionality
>>>> is presented to administrators.
>>>>=20
>>>> In nfs.conf, [nfsd] looks like it controls what options are
>>>> passed
>>>> via
>>>> rpc.nfsd. That still seems like a confusing admin interface.
>>>>=20
>>>> IMO admins won't care about who is talking to whom. They will
>>>> care
>>>> about
>>>> how the export pathnames are interpreted. That seems like it
>>>> belongs
>>>> squarely with the exportfs interface.
>>>>=20
>>>=20
>>> With the exportfs interface, yes. However it is not specific to the
>>> exportfs utility, so to me [exportfs] is more confusing than what
>>> exists now.
>>>=20
>>> OK, so what if we put it in [general] instead, and perhaps rename
>>> it
>>> "export_rootdir"?
>>>=20
>> I'm just catching up... my apologies tartness...
>>=20
>> So setting root_dir effects *all* exports in /etc/exports?=20
>> If that is the case, that one variable can change hundreds
>> of export... is that what we really want?
>>=20
>> Wouldn't be better to have a little more granularity?=20
>=20
> Can you explain what you mean? The intention here is that if you have
> all your exported filesystems set up in a subtree under
> /mnt/my/exports, then you can remove that unnecessary prefix.
>=20
> So, for instance, if I'm trying to export /mnt/my/exports/foo and
> /mnt/my/exports/bar, then I can make those two filesystems appear as
> /foo, and /bar to the remote clients.
>=20
> If an admin wants to rearrange all the paths in /etc/exports, and make
> a custom namespace, then that is possible using bind mounts: just
> create a directory /my_exports, and use mount --bind to attach the
> necessary mountpoints into the right spots in /my_exports, then use
> export_rootdir to remove the /my_exports prefix.

Just to be clear, do you expect that each mount namespace on a
Linux NFS server would have its own /etc/exports and /etc/nfs.conf ?

Maybe you stated that before, and I missed it.


>> As for where root_dir should go, I think it makes senses
>> to create a new [exportfs] section and have mountd read it
>> from there. I think that would be more straightforward if
>> we continue with the big hammer approach where any and all
>> exports are effected.=20
>>=20
>=20
> Fair enough, I can add the [exports] section if you all agree that is
> an appropriate place.
>=20
> --=20
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com

--
Chuck Lever
chucklever@gmail.com



