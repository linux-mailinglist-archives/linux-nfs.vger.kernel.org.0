Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA33D32A94D
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Mar 2021 19:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580754AbhCBSUB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 Mar 2021 13:20:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244388AbhCBMBf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 2 Mar 2021 07:01:35 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53879C06178B
        for <linux-nfs@vger.kernel.org>; Tue,  2 Mar 2021 03:50:55 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id c6so24838401ede.0
        for <linux-nfs@vger.kernel.org>; Tue, 02 Mar 2021 03:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=puzzle-itc.de; s=google;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AVkjDE4pXjK48gn1OzuIA1JB4gXrRMLHglrmzybvuKI=;
        b=f4VB/zjFAkzdqc6kRQkx80XKsOIt10dV/FwaQuDMU4gvcAZhhRZEdoiLQb2Mkx8AGV
         s8OG2MgkNn5FgBxzatha6EDK6VmCgpoHeV8rH6r/zEgLYa5Itkq8TUI6mYj2rw/o3pv8
         YtDeKbciK0Hzp14uw61sV+EN9vFz/icKlnplI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=AVkjDE4pXjK48gn1OzuIA1JB4gXrRMLHglrmzybvuKI=;
        b=TrV2bhgbjQJuNToepQmjo7oWhhmjT3lC2baC6s+mDDL9l4lZR/eV+5yX/y2M50osWM
         mrt/P6NJAMBeoYAS+BcajVViTgE7gin2LhE03QxgQnJtDyHkHlMa7B2d+fJPs5PBKmx5
         Vfu8LTq6YF2uV5haTpjjePBbu8zy+NS2Hncl+6APc+DSp44zSso4YEkQ3mr7vdihgjKk
         a+mbXaopMeHGQu8S8ujOfqmPE55uvvgqjSNK003GSo1pPLzn7H2jJkIPbsOyiQDtb59H
         7mF47JTmPuAFHaDmmQYuycwq1NuLMLSH31gIMY7O/xtS698L8jr4TagNwhLF6V1aU0sT
         mITA==
X-Gm-Message-State: AOAM533ZFJXUNzS34uNcBe3BXBL6DK5AP4AEwGXGy5dMRQskr/esz/et
        Fxbw8PRMfWrrxn8crAAtavsLclQkhNKzDzxyBF51yhw8zE9kyX/7d5cuicqq5gCfUH5kiff0jkb
        sRE549741b82Bb4nyPhHZnw==
X-Google-Smtp-Source: ABdhPJwU0HZi8dWr9+QNHzGrUG4p1uEClrRQpogInUJU0JdtGci4gYciTS4+W3NaAsdDJ5iav0+CFQ==
X-Received: by 2002:a05:6402:4252:: with SMTP id g18mr20753189edb.231.1614685853854;
        Tue, 02 Mar 2021 03:50:53 -0800 (PST)
Received: from tuedko18.puzzle-itc.de ([2a02:8070:88b7:3700:cd8b:c6f5:660b:7492])
        by smtp.gmail.com with ESMTPSA id g2sm18023385ejk.108.2021.03.02.03.50.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Mar 2021 03:50:53 -0800 (PST)
Subject: Re: [PATCH] sunrpc: fix refcount leak for rpc auth modules
To:     Chuck Lever <chuck.lever@oracle.com>,
        Bruce Fields <bfields@fieldses.org>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <20210226230437.jfgagcq5magzlrtv@tuedko18.puzzle-itc.de>
 <C2704113-2581-4B58-806B-BB65148AC14B@oracle.com>
 <20210301162820.GB11772@fieldses.org>
 <F2DE890D-C2D7-476A-AF6F-949B105728E9@oracle.com>
From:   Daniel Kobras <kobras@puzzle-itc.de>
Autocrypt: addr=kobras@puzzle-itc.de; keydata=
 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
 p63U1j1sBdH4lyrWIu/HHjYDEL8+XTvqMCBEHuI=
Organization: Puzzle ITC Deutschland GmbH
Message-ID: <61920dd6-31d6-b12a-9a9b-7e7a662a12c3@puzzle-itc.de>
Date:   Tue, 2 Mar 2021 12:50:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <F2DE890D-C2D7-476A-AF6F-949B105728E9@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi all!

Am 01.03.21 um 18:44 schrieb Chuck Lever:
>> On Mar 1, 2021, at 11:28 AM, Bruce Fields <bfields@fieldses.org> wrote:
>>
>> On Mon, Mar 01, 2021 at 03:20:24PM +0000, Chuck Lever wrote:
>>>
>>>> On Feb 26, 2021, at 6:04 PM, Daniel Kobras <kobras@puzzle-itc.de> wrot=
e:
>>>>
>>>> If an auth module's accept op returns SVC_CLOSE, svc_process_common()
>>>> enters a call path that does not call svc_authorise() before leaving t=
he
>>>> function, and thus leaks a reference on the auth module's refcount. He=
nce,
>>>> make sure calls to svc_authenticate() and svc_authorise() are paired f=
or
>>>> all call paths, to make sure rpc auth modules can be unloaded.
>>>>
>>>> Fixes: 4d712ef1db05 ("svcauth_gss: Close connection when dropping an i=
ncoming message")
>>>> Signed-off-by: Daniel Kobras <kobras@puzzle-itc.de>
>>>> ---
>>>> Hi!
>>>>
>>>> While debugging NFS on a system with misconfigured krb5 settings, we n=
oticed
>>>> a suspiciously high refcount on the auth_rpcgss module, despite all of=
 its
>>>> consumers already unloaded. I wasn't able to analyze any further on th=
e live
>>>> system, but had a look at the code afterwards, and found a path that s=
eems
>>>> to leak references if the mechanism's accept() op shuts down a connect=
ion
>>>> early. Although I couldn't verify, this seem to be a plausible fix.
>>>>
>>>> Kind regards,
>>>>
>>>> Daniel
>>>
>>> Hi Daniel-
>>>
>>> I've provisionally included your patch in my NFSD for-rc topic branch
>>> here:
>>>
>>> git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
>>>
>>> Your bug report seems plausible, but I need to take a closer look at th=
at
>>> code and your proposed change. Would very much like to hear from others=
,
>>> too.
>>
>> So, the effect of this is to call svc_authorise more often.  I think
>> that's always safe, because svc_authorise is a no-op unless rq_authops
>> is set, it clears rq_authops itself, and rq_authops being set is a
>> guarantee that ->accept() already ran.
>>
>> It's harder to know if this solves the problem, as I see a lot of other
>> mentions of THIS_MODULE in svcauth_gss.c.
>=20
> Perhaps a deeper audit is necessary.
>=20
> A small code change to inject SVC_CLOSE returns at random would enable
> a more dynamic analysis.

I've managed to come up with simple reproducer for this bug:

On a working krb5 NFS mount from a test client, check which enctype is
used in the ticket for the NFS service. Then unmount, and exclude this
enctype from permitted_enctypes in the server's /etc/krb5.conf.[*]
Trying to mount again from the test client should now fail (EPERM), and
each mount attempt increases the refcount of the server's auth_rpcgss
module (by 22 in my test).

Exchanging sunrpc.ko for a version with the patch applied, and
re-running the same test, the refcount remains constant instead. This
confirms the initial analysis, and indicates the fix is actually correct.

[*] For a quick test in a standard setup, I've used
      [libdefaults]
      permitted_enctypes =3D aes128-cts-hmac-sha1-96
      (...)
    to make the normal AES256 tickets fail. A more realistic scenario
    would be a client that's restricted to RC4, and a server with
    RC4 keys on the KDC, but only AES allowed in krb5.conf. Default
    behaviour of typical AD join tools makes it easy to end up in a
    situation like this.

>> Possibly orthogonal to this problem, but: svcauth_gss_release
>> unconditionally dereferences rqstp->rq_auth_data.  Isn't that a NULL
>> dereference if the kmalloc at the start of svcauth_gss_accept() fails?
>>
>> Finally, should we care about module reference leaks?
>=20
> I would prefer that module reference counting work as expected. When it
> doesn't that tends to lead to people (say, me) hunting for bugs that
> might actually be serious.

The refcount leak is the easily visible consequence, but the skipped
call to svcauth_gss_release() probably also leaks a small amount of
memory for each request. Repeating the test case above for a longer
period of time (eg. by throwing an automounter into the mix), this might
eventually become noticeable.

>> Does anyone really *need* to unload modules?
>=20
> Anyone who wants to replace the module with a newer build that fixes a
> bug. It avoids a full reboot, and for some that's important.

Switching from rpc.svcgssd to gssproxy without taking down the machine
as a whole was the situation that originally prompted me to look into
this, but I admit that's a rather rare use case.

>> And will bad stuff happen when the
>> count overflows, or does the module code fail safely somehow in the
>> overflow case?  I know, bugs are bugs, I should care about fixing all of
>> them, shame on me....
>>
>> --b.
>>
>>>
>>>
>>>> net/sunrpc/svc.c | 6 ++++--
>>>> 1 file changed, 4 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
>>>> index 61fb8a18552c..d76dc9d95d16 100644
>>>> --- a/net/sunrpc/svc.c
>>>> +++ b/net/sunrpc/svc.c
>>>> @@ -1413,7 +1413,7 @@ svc_process_common(struct svc_rqst *rqstp, struc=
t kvec *argv, struct kvec *resv)
>>>>
>>>> sendit:
>>>> 	if (svc_authorise(rqstp))
>>>> -		goto close;
>>>> +		goto close_xprt;
>>>> 	return 1;		/* Caller can now send it */
>>>>
>>>> release_dropit:
>>>> @@ -1425,6 +1425,8 @@ svc_process_common(struct svc_rqst *rqstp, struc=
t kvec *argv, struct kvec *resv)
>>>> 	return 0;
>>>>
>>>> close:
>>>> +	svc_authorise(rqstp);
>>>> +close_xprt:
>>>> 	if (rqstp->rq_xprt && test_bit(XPT_TEMP, &rqstp->rq_xprt->xpt_flags))
>>>> 		svc_close_xprt(rqstp->rq_xprt);
>>>> 	dprintk("svc: svc_process close\n");
>>>> @@ -1433,7 +1435,7 @@ svc_process_common(struct svc_rqst *rqstp, struc=
t kvec *argv, struct kvec *resv)
>>>> err_short_len:
>>>> 	svc_printk(rqstp, "short len %zd, dropping request\n",
>>>> 			argv->iov_len);
>>>> -	goto close;
>>>> +	goto close_xprt;
>>>>
>>>> err_bad_rpc:
>>>> 	serv->sv_stats->rpcbadfmt++;
>>>> --=20
>>>> 2.25.1
>>>>
>>>>
>>>> --=20
>>>> Puzzle ITC Deutschland GmbH
>>>> Sitz der Gesellschaft: Eisenbahnstra=C3=9Fe 1, 72072=20
>>>> T=C3=BCbingen
>>>>
>>>> Eingetragen am Amtsgericht Stuttgart HRB 765802
>>>> Gesch=C3=A4ftsf=C3=BChrer:=20
>>>> Lukas Kallies, Daniel Kobras, Mark Pr=C3=B6hl
>>>>
>>>
>>> --
>>> Chuck Lever
>=20
> --
> Chuck Lever

Kind regards,

Daniel
--=20
Daniel Kobras
Principal Architect
Puzzle ITC Deutschland
+49 7071 14316 0
www.puzzle-itc.de

--=20
Puzzle ITC Deutschland GmbH
Sitz der Gesellschaft: Eisenbahnstra=C3=9Fe 1, 72072=20
T=C3=BCbingen

Eingetragen am Amtsgericht Stuttgart HRB 765802
Gesch=C3=A4ftsf=C3=BChrer:=20
Lukas Kallies, Daniel Kobras, Mark Pr=C3=B6hl

