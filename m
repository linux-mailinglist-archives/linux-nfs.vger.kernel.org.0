Return-Path: <linux-nfs+bounces-121-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E085E7FB0A3
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Nov 2023 04:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC2C41C20AC4
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Nov 2023 03:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272E24C7D;
	Tue, 28 Nov 2023 03:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail3-165.sinamail.sina.com.cn (mail3-165.sinamail.sina.com.cn [202.108.3.165])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0910101
	for <linux-nfs@vger.kernel.org>; Mon, 27 Nov 2023 19:41:25 -0800 (PST)
X-SMAIL-HELO: smtpclient.apple
Received: from unknown (HELO smtpclient.apple)([114.254.9.192])
	by sina.cn (172.16.97.32) with ESMTP
	id 6565616200033B87; Tue, 28 Nov 2023 11:41:23 +0800 (CST)
X-Sender: thfeathers@sina.cn
X-Auth-ID: thfeathers@sina.cn
Authentication-Results: sina.cn;
	 spf=none smtp.mailfrom=thfeathers@sina.cn;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=thfeathers@sina.cn
X-SMAIL-MID: 32448412846452
X-SMAIL-UIID: 1C8A06676BF444C4B99B409BF0A1F2A1-20231128-114123-1
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: thfeathers <thfeathers@sina.cn>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] SUNRPC: _xprt_switch_find_current_entry return xprt with condition find_active
Date: Tue, 28 Nov 2023 11:41:21 +0800
Message-Id: <609DC0E2-4262-43A3-A9CF-54AEC3FD5383@sina.cn>
References: <CAN-5tyHKddhV4OKL+ZhKKTXwoPiSug6rzRtv=Fq9KsY2wH0iPw@mail.gmail.com>
Cc: NeilBrown <neilb@suse.de>, Trond Myklebust <trondmy@hammerspace.com>,
 jlayton@kernel.org, chuck.lever@oracle.com, tom@talpey.com, Dai.Ngo@oracle.com,
 kolga@netapp.com, linux-nfs@vger.kernel.org
In-Reply-To: <CAN-5tyHKddhV4OKL+ZhKKTXwoPiSug6rzRtv=Fq9KsY2wH0iPw@mail.gmail.com>
To: Olga Kornievskaia <aglo@umich.edu>
X-Mailer: iPhone Mail (18G82)



> =E5=9C=A8 2023=E5=B9=B411=E6=9C=8828=E6=97=A5=EF=BC=8C06:26=EF=BC=8COlga K=
ornievskaia <aglo@umich.edu> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> =EF=BB=BFOn Mon, Nov 27, 2023 at 11:31=E2=80=AFAM NeilBrown <neilb@suse.de=
> wrote:
>>=20
>>> On Tue, 28 Nov 2023, Trond Myklebust wrote:
>>> On Mon, 2023-11-27 at 23:39 +0800, jsq wrote:
>>>> [You don't often get email from thfeathers@sina.cn. Learn why this is
>>>> important at https://aka.ms/LearnAboutSenderIdentification ]
>>>>=20
>>>> current function always return a active xprt or NULL no matter what
>>>> find_active
>>>=20
>>>=20
>>> This patch clearly breaks xprt_switch_find_current_entry_offline().
>>=20
>> I think it actually fixes xprt_switch_find_current_entry_offline().
>>=20
>> Looking closely at _xprt_switch_find_current_entry:
>>=20
>>                if (found && ((find_active && xprt_is_active(pos)) ||
>>                              (!find_active && xprt_is_active(pos))))
>>=20
>> and comparing with similar code in xprt_switch_find_next_entry:
>>=20
>>                if (found && ((check_active && xprt_is_active(pos)) ||
>>                              (!check_active && !xprt_is_active(pos))))
>>=20
>> There is a difference in the number of '!'.  I suspect the former is
>> wrong.
>> If the former is correct, then "find_active" is irrelevant.
>=20
> Thanks Neil for pointing it out. We need the "find_active", otherwise
> as Trond pointed out it breaks the offline function. But I do believe
> I missed the "!" in the logic. I believe the reason this hasn't caused
> problems is because for the offline transports we never use the
> xprt_iter_xprt(). We only iterate thru the get_next when we iterate
> offline transports. But I should fix the function that adds the "!".
>=20
return a xprt active state EQUAL find_active
maybe =E2=80=9C&&=E2=80=9D =E2=80=9C||=E2=80=9D =E2=80=9C!=E2=80=9Dlogic not=
 need
>>=20
>> NeilBrown
>>=20
>>> Furthermore, we do not accept patches without a real name on a Signed-
>>> off-by: line.
>>>=20
>>> So NACK on two accounts.
>>>=20
>>> --
>>> Trond Myklebust
>>> Linux NFS client maintainer, Hammerspace
>>> trond.myklebust@hammerspace.com
>>>=20
>>>=20
>>>=20
>>=20
>>=20


