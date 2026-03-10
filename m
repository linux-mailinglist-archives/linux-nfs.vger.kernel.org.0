Return-Path: <linux-nfs+bounces-19979-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CakL1IlsGnYgQIAu9opvQ
	(envelope-from <linux-nfs+bounces-19979-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Mar 2026 15:06:10 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8778825154B
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Mar 2026 15:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1C0E5326F93B
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Mar 2026 13:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC0F391E6B;
	Tue, 10 Mar 2026 13:28:34 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020108.outbound.protection.outlook.com [52.101.195.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF66D38D694
	for <linux-nfs@vger.kernel.org>; Tue, 10 Mar 2026 13:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773149314; cv=fail; b=hKanzjrXv3HZRk6Y3HVvMLC2Np4HjZ9Sf4wxsxW8+Sz46/Rpq+HyR/gfi4XjVwAt363tFe3MZjk55S+M2FJd02dpQsYeNhzpQwX8DJx4WF8nOcmpboDr0kmUogMNxYies2g+4Py+0EV+Mi1kv2kzk+Nr1e2AdBOnBWHrhs+ez6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773149314; c=relaxed/simple;
	bh=4S42txvfOpFgevMXtVMuUyRMTzIZ010XZ26/nzmUqB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=k+iVOenHOnZGlsL/O7UIafqPe7CKx/mGjjbwOLkj9r5qBKV8GZ6D94j5eCaaKSZC9jCFCd6oh/nhLyJqmEWNeMM8WlxQvdnS0UEjwGbWOQPXMuwesoS8RIdO0SDHD/8/Jga2g7HUkjkgRsHy804JcsAu40qfJofLFCLvi7lYTRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yjChT/gqVE99QfT/2aMPY6SY3MnOU+pZQda7b7n3LJevH4VIT6B19LFcnr8hP5EyTKYFiow8gL4MSDm5tbOkbteKFQjNRRMpH0XnC0/0DWHsIDt05HftKk7JwFhgfA1NV9fCqglEO0+iROnywsY2ll1wpMiEOlolxzwQ/3zt9EOkWa00+oe+TknF99YPmFovXqvRcgB4jKK+OhynX8tpR1SJ0jHqTNpmgsGamNatVQ0Rh42oxRr886QDVoie/QGdk/gbCK6kNMoTJswcylS+Ka8jnLLTRyLhe+TeICuumdsVd6Vt+8T9BirR4YjsPzP2NRIBI3FxrSUDNJmdGPbAqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TQB4CtpjEwSC+ypEG26mfa4yEkk9kYE1JgU0Bc44pl4=;
 b=ORQ/ClHxE3cZKeyz1Mmvmtf8ooZrRoS034fXKL+Ko3UOD45N9Q3fUmTU0xzmg841TE31qFWzeSfMehDyaJ8n0f+Cm18swE+wmVJcISfCGhDn7N+T32+CpARMDk1cF+iUumz+hM3egR/+itCUcaMpp7pUigt8FyNG5dFWUi+vIRedADITtBEzOYY/4cK8Khv6AYJC+OI9ID3avdhF45m7C9GxFEjz4mEFxzcwRyPHNOHb/LTFAMlhcCJB9cqga+90k0xqANAZPA6u1uHvLcFv08fgi+tlrzdbiB6j+NOAsvcB6XtkHlZIL3VB2m1uwrLR4bU+NJLZ18OlEaJPZx5qGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO9P123MB7879.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:3a1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Tue, 10 Mar
 2026 13:28:29 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9678.017; Tue, 10 Mar 2026
 13:28:29 +0000
Date: Tue, 10 Mar 2026 09:28:26 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Steve Dickson <steved@redhat.com>
Cc: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] Revert "nfsrahead: enable event-driven mountinfo
 monitoring and skip non-NFS devices"
Message-ID: <pfrnxhemafqrmfgvo26j5dal4o7g4sxu5thtdgwmwxvlwabynh@p6ssyobhcehn>
References: <20260310123623.53580-1-steved@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iyp3xqbdmavj3q65"
Content-Disposition: inline
In-Reply-To: <20260310123623.53580-1-steved@redhat.com>
X-ClientProxiedBy: MN0P223CA0015.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:52b::9) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO9P123MB7879:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ff9acad-93e3-429c-8d60-08de7ea8eae3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|22082099002;
X-Microsoft-Antispam-Message-Info:
	LX5OELV80hkf7pfVqyuETT0vEopDuNk13ZhmbDTRanlVG9gA269sZrh7KuaBgwMEMi6AlGHyyokrL8FKrGcV6On7LTwECR9m/2FwV4pB4Wq+1BnJycJvOFoKmS2tYRdEv3byI5tgNgHlI3nBR+e5Hx+f3Q+hhWdVsf8WidPUrcGCTJfqszkr2IzxyBGm9MjiMUnZm6Zj6n0TzFxeyYttVC7Msj8ELzpLjukyk7pIBlGmBxtIBvDRahbLsQzk82Dyl65bTHHl/hD26ivWLOX6RU17Iad7OI2YiOCossz3m3EUZZ2HgohI2eUX82I7IfmaI9qBGZMeYME+NEoKj5mDeqxHmHBcseTcVETWVli//5P8V7nv/B2DPwtROKrpr4upd5v4SsPdT+ql/bNM0pMNef4pqLKpVIirbeGYH6XHTKvPagNJE4YJSyP/TbC4q7BjlCUd7SOZy0uZDR+3Cpx2FTTqvAjRyZzVuJ18ea746YQxXS7KJP8FaBNkRECGA1/mgYwlNL+6lSZpYVHuuoTE8HhYjTxuIqI/qgm9ZDhYDdbwxU/AxY6EF5KccNqIPOJP+I8Hf4UQfqpqfO0ZELN7Myd5uz38Dm+h0Z36FF8aQYTyJ/Uuy/kY7auL2V+krWjkDVSZPkD8HH/mtXr6RW0xbZ3RaG4o6raQPd3IokxuINV2K/2or1zhaaBdkwGXHDZM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(22082099002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHFlMWpyVklCdWFnVDRYL1RNUldhemJGMTU3N1dMVVFHbHZnNHg4RkNTeWF3?=
 =?utf-8?B?UEdzNHZ2dU44WnRpV3RqWnV1dU0wUU5valRJeFNOdjlYSUJPWk1aWmREdVho?=
 =?utf-8?B?UkN4R0ROdEdVZWFuT3RwOGU3L09VMmZYQnZQUnA3M1VvTk1SUnJaZ3RDa3Iy?=
 =?utf-8?B?SER3VGxyWjZ1U1lZMyt1aDlOdG9jMFN5c213NGxoWE52ZFBJdUg2Nm1ITjdQ?=
 =?utf-8?B?M3RaUW1nNXMyc3FURklCcmtLc3BkVndja3dBa1ZTbWhLK3R2RzFBa2g5c1pX?=
 =?utf-8?B?cEJFSVNXSC90VG95YjUyZWFrWjNWNGUralprRjAyc29jbml6WW5YRVdhaW9y?=
 =?utf-8?B?UXBVcEVNSytJUTdIQW44ejZSbGEzMUNjYjBMWWhXUnNpR1FjaWVxRnlBV0ly?=
 =?utf-8?B?SUpneDIwM29NVzR1aDhoOHlzUUV5bnB3TE1GNzVJY29COFBJUGdOckJzVnVU?=
 =?utf-8?B?TllyOWhLdGVob2xpSmVCcHNjTkxLYnUzVC81dSttTVk4VFM2ZGdtbVdPc29L?=
 =?utf-8?B?Q3BTK2hPNm1BSVJkWllTNU5LWlNRN2g4NlFINUZKMEsyWCsvQmhqTjQ2NWx1?=
 =?utf-8?B?M3lKQjR1aDJ1Wmc4NEdocktaMytaVWIxTU9zMS9zbXFRcW0ySmtpVWlXb2pq?=
 =?utf-8?B?bmdwTDJDVEJUd2FwbWJLcUlENFFScnI5cEJwQVpsekE5VXpPRzBlbXMrbEIr?=
 =?utf-8?B?TjFjY3NjOUVrMHAzTERJZWI5TWR5Ly9KalBodEVYTjlrZzBUeDExZ2ZpeTNw?=
 =?utf-8?B?ZGJnZ29xYTJHK1ZPcElYWnZtKy9TTDJOcWQ2Z1psak5Gb0IzSGxOejRWR2tP?=
 =?utf-8?B?K2phRFUwNTljNFNuTVplUVZGbmlEZVBWQjlmbVZYOCt0TFQ5blE5V2JlVDVW?=
 =?utf-8?B?eGxiZURSUXM0NG5ueHRUMWVEYmtHRUJkNUIzV3NTeDIvRkhtcTMvb1QrVVE1?=
 =?utf-8?B?ZGI5RjZodmlnOXFkcS92bmJCUEVQOENSaWJBN0p2OVJjSHp3ZENqVFdhdE80?=
 =?utf-8?B?cWRrOVBBWUJ2Um5lM0FMS2FSUkVTU1graG5jSTJNbDNtS044WXNGem9IMTBR?=
 =?utf-8?B?V2g0dE43YmZEREcyellpR0VXM3IzdFZ3U00vZVlTRlVtbS9mYi9nRGQ2Ym1J?=
 =?utf-8?B?S0FpYUlRUWNzRGxDbXRKUFFoOHR2OGpnKzViZzg1R1d4YUZFWkQ4VW1YMzBT?=
 =?utf-8?B?N2VYQWZrd203TXpyYlJhOVl5UDVqeXZEd0xEOVk4aGN3QU1YM3czOWZwVURO?=
 =?utf-8?B?OVdRbUlaMkk0dmcxZmFXTThJNzE5bW5KUkh3aVh2dUdEcjVzQmQydG9KMmtW?=
 =?utf-8?B?aWhkaFdORGorN25aSGhIRTdMT1FqMzRxRnVRYzA5NEVNc0lxZ3RuQXdjVFR6?=
 =?utf-8?B?QXJoSUw1V0RVeWVjT09TNUFaS3NuWEdyRzN5NWlWT3lXaThFZllmZjZnd3Bs?=
 =?utf-8?B?enJWdFhqMHJVRWFMVVdCZDRUT1lXbnFkMXIxRFo2K2MzcGVOaGNiYVZPL1dZ?=
 =?utf-8?B?ZG9hQlhjN0RMU213Q1l2NGtTNUdyckJMeXhSZ0JHQWl6RzVUN3Z4dkFSY0ZG?=
 =?utf-8?B?Mnl3WFlKZFZ5SUpIWmVEYjlwSDVNQWxMbytYOWxXMnpHMkdDb3diWHFEaE9Z?=
 =?utf-8?B?VGJLb2ZlVXYyZFI4MHBLalJRN0U4Z0R6QmRpVjJNb0wwbnNobEw0TUZva2ZP?=
 =?utf-8?B?ZmdhUitza1R1YWl1SWNiMnJUMW9tT2xKdkhUT2ZJMzdWNURkKzdlV0ptaUdu?=
 =?utf-8?B?b2ZwM2Q1VHkyMTkzRVlHL1RiNE52NXZwTGhDQklwV21aeXFnTS9OSmtlWkxT?=
 =?utf-8?B?OGJDc1l1SHAxd3FGL3NPelVvQTZ1Ly81TmNwcEVUcFc1ZHNrNlRhOU5Uc1Ja?=
 =?utf-8?B?VUtsZHFOZU1PemtUNE9LcVFvZ0FnSWZHZm5LdTR6Vmt3MGFVLzVGSnNFYzJv?=
 =?utf-8?B?TUt1b296VExxZ3VqUjU1T3BKZnZjZlMwcXVTVEpoV1I3dG5Bb1BXL28rOUh0?=
 =?utf-8?B?SUJTSWhLci9YUjU5a2lkN09TM1dNY0wzeC9tWUFDQnBFcjlOZ2pVQ1dMaEtk?=
 =?utf-8?B?ZWVVbnlLaXRaTThBQVEwN3BBNDNEL1FWTVpYamQ3MTlJTVlyUCtXWkF0bDk1?=
 =?utf-8?B?M2RZYUsxSUczbSs0Y1p6aS92S2FVWjYzTFlsTkRnNGEzSUVlZlo3OWxIVlp1?=
 =?utf-8?B?djlDcXRadU1qVjk4bkQ0WXcxR2ZRa0k5NHlQdXBLWi9iTzFiaUNFd0IrakVr?=
 =?utf-8?B?OTRVS2FkZW9qTzdoUnBSMjd5YXU3bGErb0w1d2JudW5tTy9ja2hyUG5kdEJG?=
 =?utf-8?B?dHRQSWpXM2ttZVhrTEpTdlBNVndyTWV0d0N1d3c5dENvRHByZVRyQT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ff9acad-93e3-429c-8d60-08de7ea8eae3
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 13:28:29.5775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S/tqTFYuJkTyEGBjoBerqFn6VwJ3sSioEsHdOucCjfjllcqVvrr6HsphQ+DXGYui5AbGzDPICINDYaUwPCwOxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO9P123MB7879
X-Rspamd-Queue-Id: 8778825154B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.06 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19979-lists,linux-nfs=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[atomlin.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atomlin@atomlin.com,linux-nfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.966];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

--iyp3xqbdmavj3q65
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] Revert "nfsrahead: enable event-driven mountinfo
 monitoring and skip non-NFS devices"
MIME-Version: 1.0

On Tue, Mar 10, 2026 at 08:36:23AM -0400, Steve Dickson wrote:
>  #1  0x00007f1a8670b15e raise (libc.so.6 + 0x1a15e)
>  #2  0x00007f1a866f26d0 abort (libc.so.6 + 0x16d0)
>  #3  0x00007f1a866f373b __libc_message_impl.cold (libc.so.6 + 0x273b)
>  #4  0x00007f1a8676f665 malloc_printerr (libc.so.6 + 0x7e665)
>  #5  0x00007f1a8676f684 malloc_printerr_tail (libc.so.6 + 0x7e684)
>  #6  0x00005624543b1d32 main (/usr/libexec/nfsrahead + 0xd32)
>  #7  0x00007f1a866f45b5 __libc_start_call_main (libc.so.6 + 0x35b5)
>  #8  0x00007f1a866f4668 __libc_start_main@@GLIBC_2.34 (libc.so.6 + 0x3668)
>  #9  0x00005624543b1fb5 _start (/usr/libexec/nfsrahead + 0xfb5)
> ELF object binary architecture: AMD x86-64

Hi Steve,

> https://bodhi.fedoraproject.org/updates/FEDORA-2026-e033b6bafe
>=20
> This reverts commit 0f5fe65d83f7455112aea82bf96f99523cb03ca7.
> ---

I thought this was resolved with [PATCH 1/2] nfsrahead: zero-initialise dev=
ice_info struct [1], no?

[1]: https://lore.kernel.org/linux-nfs/20260309145025.107623-1-atomlin@atom=
lin.com/T/#t

Please note that series [2] is based on this particular patch.


[2]: https://lore.kernel.org/linux-nfs/20260309145025.107623-1-atomlin@atom=
lin.com/T/#m1309a5bf24457934f3d2db7ca5706e240aae51d1


Kind regards,
--=20
Aaron Tomlin

--iyp3xqbdmavj3q65
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEeQaE6/qKljiNHm6b4t6WWBnMd9YFAmmwHHoACgkQ4t6WWBnM
d9ZfsxAAp1gDva6mDgbEMEPDyx6UN7iNskviv3dwctwqinsleVogWv+2Q1G5g1lY
k3hMGEzVjnchh66uieibJZTt3YPH+DNUYI+abkV6FIvrCfHVKrAjtSdNXXxcwTV0
sK8UbDCMddEyBbTonuhZ5yLlNcZHPGAbKC4RwfK6J0TyHKyYZVXmW8xDPaFCXGkV
bJG6xZAdx53VvzbS5b+hFQHxmgxRxEGjCm2b1Drvs2Gu88L+nKX82QXlDJRxUF8X
jjEpk/ScGRBoGQ31aJnD+4g9Ta56vNToy2ChnojPqB0/6aDfDMpn68f424+DnZ0W
2hARbFtuBhXtvq14ZzVlYgsx2zRLOtymiJoyFYmh6MMx00u1mBV2HoNQvDlHX72b
xh7SNchCeCFSdxOcAIe5u2rypI39SrxaQHYPafiGlstqsB0uh6+jOt0Bf+5alPVF
gUF9tBUZoTTUJqL+HGbr1rYJOKzufzbxs9DI7iSifr9s5Q8J9UIJNDU5lFWq0+5i
6vlbcfLQKhlBWn4j88o2tfXwHCHn6jl0yematuJjnVbOsa/bxZ4pKqbRwAFzTI5f
8TAAcVoqE3q7jMIwG4hZq4UmFAA9oBm97lsSjduIIrFvneWthdD9B/YMQSgp1AJw
0E0FqTZosJbDVKmkQXYvfyCCGCaai4+a5tlcNMVI286IkgwWPic=
=DUDP
-----END PGP SIGNATURE-----

--iyp3xqbdmavj3q65--

