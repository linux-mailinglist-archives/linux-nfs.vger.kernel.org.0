Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5097128E479
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Oct 2020 18:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbgJNQbB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Oct 2020 12:31:01 -0400
Received: from sonic312-30.consmr.mail.ne1.yahoo.com ([66.163.191.211]:45117
        "EHLO sonic312-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728084AbgJNQbA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 14 Oct 2020 12:31:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1602693059; bh=ACnLzg1vMXlVyI32YNdSkKII1lco6l3vKA4yg3stZOM=; h=To:Cc:References:From:Subject:Date:In-Reply-To:From:Subject; b=niRjGs6cm3BnK8cg9c375Q8mfJpBLh9HnqeTPvQoauXEtSe1YFQXZh4Zktw5+ZhI1fNp4Cn+Kga37Ng/Jb4/2EakXzQZ4PnRtPyIUi4aEprTFDaE5D1KsgvxBB7mSiYI1SNb5zs7qv6A9Xi9njWhxSA2b6etLSlka00ylmgSJlD7vacQL+ZhKA1oOgroCRFMIZFLGO/pCSAUc5OCr3eKn4bbVGNEHciPSUVJ6SInHQxSYColJWzUl9sL2irCaMoviOmAcYDz5fARzBLXjPHldBfbBCREevfgzSwwGsBEaC5ufOrxLO4ZWS3szFaOhlZ/RJpZM5PQ/6EmgeqwMEQWpQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1602693059; bh=D/IU3j5uwpbvoPOYW0Dt+CRFE8vpSQ5Y/+KGl14lrDB=; h=To:From:Subject:Date; b=QFdcO1jr/0oaPrWdeK+tK8AvBLGYoo3BvmbvnLNs7oF5k2xHzS/qT2rqBYlMvnrPH9wm7kIDJzmO1S1AzIztfG1pXugv+ESxkdr9WAJGnajHS2vvYGbNbp1dUV37mLAL+SmRzFxcUWm/do6Svx3YSIgymC4w8DaCNamiQnQBfaKR9GMR+ZiuKLiblDcURw/35VwCgl7RZWLeX76PH0iJBKk0649y1MQWgdcmaKmtqHn3eGI3bSjGEzISy/lWp9NA/xZanKbZc/xIGY3vZ7TqlWC0m4MfkLNg/n9cbxzq8BNGGwXToup0LUxXq7Xb3Fv72mXSoz85P75i0w84tgiyqA==
X-YMail-OSG: 9b4A_PoVM1n1T7iGDmnLtD49BrkpQPhn3ztgcWJKVc2B_q5Oo5DLtXGhjKlQWrf
 DZYz9gI6jqbm1I6AFuXIBkJn.68OnB0PMzqIKdqGfL8h1v.jhHkozPNquTM02pdrSOkjYuR2mEZW
 6NOeVkcj8YixKx9RcoE6qJOxGJMp95lh44oIC4f8gPaLrC5dRahHaybgdLtC4DOiD2dny415PImb
 PuaFc8S9wZAP2bk9TAe1AMBTvpBdODr9i24j8MtbUGOixcxFFi1S70SFbWvbEM___fSaw58psRmz
 oBkeNKygUd73EMaqLbq_gPd2v1WiMcWVO9pIJH7r83ihY7d239mL8I406ExNjUW8eJDS8nmzyRMa
 fQEaZWaN4C6crTnwzDzRqvxjThncNrMXCdT5PMN89Vu_YYxN_TCWlacSSVVKfgCM5.7c_ecUbBCH
 2bYQ12KFaRwtRHULx9eJG_1.vu64gTl6zp39TXcAJqGoSJoOGGe20z5DhnktDnFL23QTEWa9EMHn
 _Ef412vS7MUXufwGkzBxdZ4bHwZQr6OmzzkR4yzX.7V2rvB2OmBxFUPxZFXjP7XMf3s_QbBFfAS9
 UxpEirUpWWgkcQkXecGoI.NbpwjRPHKMFR4FfY4FPctQfv_fi5AHdTI_34WLmgCaN3eSPj.t5vhK
 w11JRFQtfbOji6r7Ax4BAgaDUoI885rsZmrYD8BUGkJM8uQjSU.4YqkK1xdEp4E4wMNJOR.8fr9T
 S820u1Pa5RTh8..xxt9LfQGhj2iU1XXraF2QPwU17Jh4Axqk5UhRKOEfSO5A_tu6WU9Gw4u92bLU
 ajpqtDsOCq9KM5xh8GDNSOLDqAeLj8EcwXCN1PhSgBjgGqx5LI94mq4M4VVUNps8dWX42ZJetQEe
 DrKAlkFyj4K1zc1wN3wNN43_YnDdmFhnjAUsUE4VVb_dB2uPyOUG0U7noA_o94rQpZY071FoA3SM
 Tss0h9qyxt6zwzeKxK8KaUOm7QeW.sSzaPXYdeO36kaS.oKgYUOO3ZH1.jCCuKRRNIEX.AzKRr0i
 YNOHyRfgw64BEjbq0eHChfxqIZI5Z43SIRhKbF3E5RHMZvhlSEQMyIblLyIrotTlbWe1HZNYLrBY
 McnaRTZRWbg8iBHRmKp2fK2MqMuYzWatHrnvGypr3XGHH4_QuyJgJECfu4TDecEg1MU6Gh3OU7LC
 nutxcUOE5s3TtkxEw2Dcaamp_5H5i1Fi_ixiyYIaxNQRfqwdWYgsRddulp3Pgcz31adAbuqtFTW0
 ZpQdN0IYNAQvIOMeFGOb69R072T3OO_Zfo_wXT2ZZ2Z8bURRFcWot7494jlU6DXMHo3zw3qaJbKz
 ZQ.PCFmkw_eub2ivVyg7LPPWQp3etGSRKKzM5i9nbmkXqZ73COe2CEbWiFOEGytdAyIuliMyfBqn
 NfHT43me06BSKY8e35Kg4JwhexfqBucUB2IIqtCclhwpOlwmI4u277neTEmIL7vayRLRqSy6UaN3
 TRlbKEmVMLxw2NDf3rsyRRSPCD0_l1T0GRzOHxtHzYUvzJO76GONQDfNlDqA0dyZ1ZaNoiiY-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Wed, 14 Oct 2020 16:30:59 +0000
Received: by smtp414.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 06e8891b9b1ba7aa28a4fd4fb3f42561;
          Wed, 14 Oct 2020 16:30:57 +0000 (UTC)
To:     Paul Moore <paul@paul-moore.com>,
        Olga Kornievskaia <aglo@umich.edu>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Chuck Lever <chucklever@gmail.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <CAN-5tyETQWVphrgqWjcPrtTzHHyz5DGrRz741yPYRS9Byyd=3Q@mail.gmail.com>
 <CAHC9VhRP2iJqLWiBg46zPKUqxzZoUOuaA6FPigxOw7qubophdw@mail.gmail.com>
 <CAN-5tyFq775PeOOzqskFexdbCgK3Gk_XB2Yy80SRYSc7Pdj=CA@mail.gmail.com>
 <CAHC9VhTzO1z6NmYz6cOLg5OvJiyQXdH_VmLh4=+h1MrGXx36JQ@mail.gmail.com>
 <CAN-5tyGJxUZb5QdJ=fh+L-6rc2B-MhQbDcDkTZNAZAAJm9Q8YQ@mail.gmail.com>
 <FB6C74CE-5D9F-4469-A49B-93CC8A51D7D5@gmail.com>
 <CAN-5tyFQbfkiuno07C6Azc7RcF3z3qF3PP0FutFMD3raBgnQmA@mail.gmail.com>
 <CAEjxPJ7PoAG6f+gVdodx=6X8+_Z_WCFXAuxnpB8WmC1gTF4iQQ@mail.gmail.com>
 <CAN-5tyEy57xoqEbZAThZKHriJywx-5DMKBD5tsXwo5ccGwuctw@mail.gmail.com>
 <CAHC9VhQpCXFySZY42==KR57hfAkVLdS6mSAcp2UHn-GWjEfVLg@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: selinux: how to query if selinux is enabled
Message-ID: <bc766b2b-d1f1-d767-579c-02e10ae32a9a@schaufler-ca.com>
Date:   Wed, 14 Oct 2020 09:30:56 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <CAHC9VhQpCXFySZY42==KR57hfAkVLdS6mSAcp2UHn-GWjEfVLg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.16845 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.7)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 10/14/2020 8:57 AM, Paul Moore wrote:
> On Wed, Oct 14, 2020 at 10:37 AM Olga Kornievskaia <aglo@umich.edu> wro=
te:
>> On Tue, Oct 13, 2020 at 7:51 PM Stephen Smalley wrote:
>>> I would suggest either introducing a new hook for your purpose, or
>>> altering the existing one to support a form of query that isn't based=

>>> on a particular xattr name but rather just checking whether the modul=
e
>>> supports/uses MAC labels at all.  Options: 1) NULL argument to the
>>> existing hook indicates a general query (could hide a bug in the
>>> caller, so not optimal), 2) Add a new bool argument to the existing
>>> hook to indicate whether the name should be used, or 3) Add a new hoo=
k
>>> that doesn't take any arguments.
>> Hi Stephen,
>>
>> Yes it seems like current api lacks the needed functionality and what
>> you are suggesting is needed. Thank you for confirming it.
> To add my two cents at this point, I would be in favor of a new LSM
> hook rather than hijacking security_ismaclabel().  It seems that every
> few years someone comes along and asks for a way to detect various LSM
> capabilities, this might be the right time to introduce a LSM API for
> this.
>
> My only concern about adding such an API is it could get complicated
> very quickly.  One nice thing we have going for us is that this is a
> kernel internal API so we don't have to worry about kernel/userspace
> ABI promises, if we decide we need to change the API at some point in
> the future we can do so without problem.  For that reason I'm going to
> suggest we do something relatively simple with the understanding that
> we can change it if/when the number of users grow.
>
> To start the discussion I might suggest the following:
>
> #define LSM_FQUERY_VFS_NONE     0x00000000
> #define LSM_FQUERY_VFS_XATTRS   0x00000001
> int security_func_query_vfs(unsigned int flags);
>
> ... with an example SELinux implementation looks like this:
>
> int selinux_func_query_vfs(unsigned int flags)
> {
>     return !!(flags & LSM_FQUERY_VFS_XATTRS);
> }

Not a bad start, but I see optimizations and issues.

It would be really easy to collect the LSM features at module
initialization by adding the feature flags to struct lsm_info.
We could maintain a variable lsm_features in security.c that
has the cumulative feature set. Rather than have an LSM hook for
func_query_vfs we'd get

int security_func_query_vfs(void)
{
	return !!(lsm_features & LSM_FQUERY_VFS_XATTRS);
}

In either case there could be confusion in the case where more
than one security module provides the feature. NFS, for example,
cares about the SELinux "selinux" attribute, but probably not
about the Smack "SMACK64EXEC" attribute. It's entirely possible
that a bit isn't enough information to check about a "feature".


