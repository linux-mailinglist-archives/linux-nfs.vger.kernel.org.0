Return-Path: <linux-nfs+bounces-20047-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kO00OV7GsWkFFQAAu9opvQ
	(envelope-from <linux-nfs+bounces-20047-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Mar 2026 20:45:34 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0DE269956
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Mar 2026 20:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5C341301DD97
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Mar 2026 19:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13EA6295DAC;
	Wed, 11 Mar 2026 19:45:30 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020113.outbound.protection.outlook.com [52.101.196.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AB62D949C
	for <linux-nfs@vger.kernel.org>; Wed, 11 Mar 2026 19:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773258330; cv=fail; b=Xs9EdKC7U+SJMO0qbwKYEiskzyQ0EBJKiA+4LQIFnjja1WoXmJmqt/40HJK5CNhZBNQtm1kuIAoHzQLugI7dxAhLcmAGVEtsepNTpwQdFYopS1kn2XaOgRLP9fIFWWYXKS04+YJ4n9Ps1tjHoVUj31V+q9EhJf2hZ9WEDaLnzmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773258330; c=relaxed/simple;
	bh=KqPzEe1oECDJQs/OdAnLCuDbhPpoQYn92ezTY85SWxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Nv2lKrikeZ+J/+EX6zgEalGT92tKEkMWkratcZsEH/0zKfJ7XzAn0yBDkIHG9iuiCqih+1aX6CAIaTtIsEup/xzyxHRaaOhibXakDm1ZlSJrsucq4V19ogjx+x7HYg79OMn1HqXb2IwjaB5BqIcsWZai9Q4lnj1a8thmh3HGsMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z8Qs8uFv0P+hjeCNrJLCy0wLnu3m5bt9K2S1hGbYcuXy11JfPYyFzxVFcNlE73xFnknpzv8MQixE1z8CGEbvhAiBwZV6FLesr4BoBFJcDadeYV5YsJb9H23HU5M7ijyKFlIYM9JwytSrCMJ3cfEUk/ouBcukWZ1O61jKpy/IQxOGVkbncp2ddecr+yNxVUeXT25eLjano3EvYkVGp7yYhDHWioJQdIc+EfNYGS3eUMo5bQB/bJ0qC9NoziBm11yy/Q2YpYOYG7IXy801yFeQUsS0rZFySoIa1ZokmXp8LfLNdTidBx2OaUOfPenflqalhH2PO9tsEblvnHAWGWFvBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KqPzEe1oECDJQs/OdAnLCuDbhPpoQYn92ezTY85SWxo=;
 b=qIg1CRD7KdjX+MRlajEk5IrcVAiChSbngVnM7eLolWhPSrUfxdPOTuDZyfxaQWBm3LKo27o+IXoP8sBf7fBxlTixHNI0rj50sXvFvG/7WnM56Njt5Bsi6CiEZLAkEHkvwi/i2sizNuyn7xp7u8DkSawhPl5Eh7L1rrMHo/cqLvnlx4uZ3z9gpDb0zy1RC95Hrc4S0/HvrOlt/14O8BzTIzM+2Zkq3Oo3Reht7BsvTEbZEdA752lLSPPCg87olhgx7DkVuG3DNxMwiMg3oNMVi16Pek80OvRrhIu8HD3Cd32Z3XA9koclc/KlGtAT73Uo+lA15pYxB2JUX49uYuDNig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from LO3P123MB3531.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:be::10)
 by LO9P123MB8484.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:45a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 19:45:22 +0000
Received: from LO3P123MB3531.GBRP123.PROD.OUTLOOK.COM
 ([fe80::adc0:1c75:f9b:9271]) by LO3P123MB3531.GBRP123.PROD.OUTLOOK.COM
 ([fe80::adc0:1c75:f9b:9271%4]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 19:45:19 +0000
Date: Wed, 11 Mar 2026 15:45:18 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Yi Zhang <yi.zhang@redhat.com>
Cc: steved@redhat.com, tbecker@redhat.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 0/2] nfsrahead: fix uninitialised memory crash and refine
 fast-path logging
Message-ID: <xchuqtbv4kfmjzl6dg4hvhuxfh3i72vcnffhqxyzwql263yzhk@dhjxvsmpqxyu>
References: <20260309145025.107623-1-atomlin@atomlin.com>
 <CAHj4cs8zCdtm7PYcbqtsQpWWCB9n71D00b5LPksLq5op7WUd=Q@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="g7euzrfwf3vjmw63"
Content-Disposition: inline
In-Reply-To: <CAHj4cs8zCdtm7PYcbqtsQpWWCB9n71D00b5LPksLq5op7WUd=Q@mail.gmail.com>
X-ClientProxiedBy: SA9P223CA0010.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::15) To LO3P123MB3531.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:be::10)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO3P123MB3531:EE_|LO9P123MB8484:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d0a47a6-ac5c-456d-85b7-08de7fa6b972
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003|7053199007|27256017;
X-Microsoft-Antispam-Message-Info:
	w/YHB0GvkJEYIzcG0Kex0T3mhrGUcfOiPqqPgSYo3SFL9e8iKY62RRW1njQNjJsKI4FKmqgf5Dtntphaf1fFXudTuK22gtQeeJVZRcCf1drUkKlZCF5wRMf+IX/pGYkWAxa1SypCKx76lGgL0c7Yrzjw2EUbxvWKNz4F8mrRQ9DR6leeqCbjhv3ljryNAHDaMtZLdMwh2hAVCL88VkfaKe4VGsDKnR/k6RhwckccBUOJOlsDLz324dxfuqMLzn8YWnvYmlESgVA5kjaDvw0oadznqqvhhhHVK9c1AtxPqiAJzkjNNXq7SessgbA7tsqqgJaFYXCjo3cNg/NBSVAf4J2QRuS0q7IrzxB35nSfxz2UGI8FdIQaRcQNM+WYoW7MglI9pSXgrRGkCPepMDYPOpqRrJVgtQQP2ROlBymOO0OTtiUtUwWbHSUGamRaY6AA+uejUCToGVTTiPRQVTFHuMecWOdWNp/Mw4ZRcUZjOlVkqEspX/nPxFZSpuDfdBUhn+R4roBwZp7YTU/kXrWDBB9h8z4bmTGJOj3bX4RSzk7EDE29lOr5i4phXq4cQEtnsrk9eBR2ONjGdMMWrpfxyWe9mfH8Ek2PXHayq7mKzO7rKCb3LAl4Me2gfe7/B+zr37tz4FfIGFOzKn7csPYGUx+oOzNVOONNQgtIxYlw1f6zu7+8TmMKJCInaDEsHpVV57ts0InxaanPokJU5KL2YTAqmQ9AGN/k7lTmwpKa1FXz2NFJZYwlq2f2E7lIuHzP4WZYnglZfiWix0f/vHNgTMogvA9iVXbpnKTXSrHWTvk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO3P123MB3531.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003)(7053199007)(27256017);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QVg3UGdOMUwxeFV2TXVWZVpIY3NjNFJzS2tnMmpZWnVpOXRwOVlwZWFkbHVs?=
 =?utf-8?B?QmU1UDFha2Qxd2gyaWdPcGNzVDRtRzhJTU55ZHpOcG0zTWF5VE1zcVJzU3ZI?=
 =?utf-8?B?WmdDNE5yTEMrKzN1Q25hOGdRVFZub2l0K0pIMmY0SzZoN1ZRUDhPa2doQWlN?=
 =?utf-8?B?QXVNbVFKZGwrL1kzVUVZZTkxMExWcys0UHhESGE5VHVCVmRHa2I2UGdRS1U1?=
 =?utf-8?B?TDZOcFRnSlF0Y1pHdW5kbGVRbXlGRk5lTVJzQnAyaUNJWkZqK0NERk5TWmF1?=
 =?utf-8?B?Z3JBVU5JdlV4V3JnRlQ5WGlZMlpYS0NMdXMyUUNzQytxZ0Z5TW10ZHdwcWVB?=
 =?utf-8?B?ckJGZnZzMzFCcndSYU9kOEJZVTQzWjBkMFRwanMwZ2RTL2NLM2QrL1RheUkx?=
 =?utf-8?B?MEtsWWVsTkV6WGpyODBVRjd2UjI2TGRDdXQvNzZmNlRCS2NsSVU5a2h6Zlpn?=
 =?utf-8?B?NkR1SW13cUlpUEpETzJpSDBzTDc2YUhzNysrL0ZrQkcwQTYxajRESnJncTdt?=
 =?utf-8?B?RXR0L0lKOE1zdXY1S3hpeWQ2bkszd3hQNWNBazk2S0d6L1Q1K0VkUVdWK3dw?=
 =?utf-8?B?d2ZKZEpPT3RVeEpzOG16eTFDK2pLdTlLMDlaWkFFaFdQOGtaalpJUHFCWXlS?=
 =?utf-8?B?VUo3VGdnbFlBWEpnTGk4dFZmY3UwSDVpdG5KYUJROGNRNnRrRk1iN1VmTGtW?=
 =?utf-8?B?d1VJU1dEWFhpYjJoME9QZHVyazNRRTFpZ3VxK2s4ZWl2VjZCU0U3WTgrZXd3?=
 =?utf-8?B?dFEyZldOZHFaMzg5YXlJR09vVVJKVlUrQThWWUxsbmhtcmxSOXJUZ3BaKzdQ?=
 =?utf-8?B?ZTB5NUk3Sk9iMUVLZ2pnUnBUS2VpbHN6L1p5bmFxWGpJemVOTDZTTkxMRFNU?=
 =?utf-8?B?SWdOUE9OQ1pSTXo1ZW55S1VwVkFDN0dYWkxzWnp2SmJXZWlpelIxbkszTnNs?=
 =?utf-8?B?Y0dFbFR4eGtFdHJSUHNHc0Zmek1OWS9aOHJpM3h2RUR1KzdqdTd1eUJ2WWlz?=
 =?utf-8?B?WTluVjVheTRvU2JxWTV5bUFuUUhpdnVicjIySEUwc3h6R2U3b3ZUNWdJZDRZ?=
 =?utf-8?B?a09XcDQxSXVzeG53ZFExTHh6ejF2ZWxxNnhvVC9OU3kwTUJ6QmdCWFdTMEdh?=
 =?utf-8?B?aE11Y2ZRLzJXZ3g2V1dnanBRc2xCSVpveCtZa3pSYWFJTXFhTjNHSVZwT2Ny?=
 =?utf-8?B?Q2xDdFY1dDE0cTFsU3QrWGh2SWpHMGgzQURpN1JFU0o3dzlYV2pFcWFJWk41?=
 =?utf-8?B?dUdUbzhFZmtCTUkwR1hwV2twM3BwZlI3aG9PZXJjTnE2SUhtWkFkMmlaSHh2?=
 =?utf-8?B?Q2JTKzRMY0tsM0NzcUxGOTJ0eFJwcGxrNWltaGhxNjBaWUhuZnNYajhNY3dH?=
 =?utf-8?B?b3kvS1lJYi82ZGVQcUQweUE4a0daeFdMR1lDd1F6cUJkbnBkUkNFRnVFTGFj?=
 =?utf-8?B?cnBzUmcxVFFHdStMcFZIK3dsdWlxajFGZU5KbHpvRnNhV1VDemdzUm9iVCtn?=
 =?utf-8?B?cmZoZExWd2pOWk9PWVlGODRkVVFJdngzNzhrUzVEbG1KaEZaZFY5amx2OEVE?=
 =?utf-8?B?SFdwcUptSll6ekV3QU1GYmFGUW0ya1dpQngxL3N5WjNrTFVaQUN5dkdxRWl4?=
 =?utf-8?B?M3c1eWd1SklCTkl2dDgwMmoybFlmeUJNcWFDUkJzdmZBY3FUaXN3bVNUT3Fu?=
 =?utf-8?B?MGZ2L0hDN2xqblBmL2d3OGhRVWJ3eHdwWm1OVDdpa1RGVWIwcHdOUmh3cGNu?=
 =?utf-8?B?TVNMZVhub0FvTmZmRjh1azJFZnd2QTN6QnBxZGZnL2FVT0RsdnVWVVhsU3kv?=
 =?utf-8?B?ZHpuNjNuSWRvTnF2ZnZKRHBxZnlKYnhlRnYzWFNLb1dZajc3cDFaNkw0QnlZ?=
 =?utf-8?B?UVNvQlc1dWQvNTFJOG9PVjJzc2JwS2R1V1J0azJaMTZqaDBSeVFSa1hTY0FJ?=
 =?utf-8?B?Wm92U0dDZkRHMVNJYlpEcGFmMUlzRXcvQ0lxOExMblVnYXNnZitRU1UxYStI?=
 =?utf-8?B?cWFUcEQ3bENpNUtGYW5nd3U0MVRJT1l2NzBTdGNScStRN0xEOC9WTyt4OFgw?=
 =?utf-8?B?SHQ4ZEYwcVdVV1kyRVZqL1k2SFQzYzJWM0Y4R0dDQkcxU25OYzVFc3lqSGhD?=
 =?utf-8?B?VjR4NlNBZ3FlSlpxcGFTb0hpWDZMdnhPUWJDV3ZkeEowcFBuYlIzU21ob1JY?=
 =?utf-8?B?MS81b0pnMGIyOXdiS2VxUmhmSWV2NDlJc3lWMUp5ZjlrYk5PYzc2MFR0RENQ?=
 =?utf-8?B?aVBLTi9rNFI3TkZ0Uy9JQldJcFBIY1dwWkxvaUZ5SDM1dXVNNzlpbWFxY1A5?=
 =?utf-8?B?amZmSks3Q29BNkpSQ2hvdEYwZzM5b3ozM0JRRGNYaktMVzJIRVN3UT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d0a47a6-ac5c-456d-85b7-08de7fa6b972
X-MS-Exchange-CrossTenant-AuthSource: LO3P123MB3531.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 19:45:19.7243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pu8Z20KzIgclCV+FKTJ+k3wgYP4/8EayJI4rlbNaIsniBboOGI8+TqhXu7XxSbj6kovkgN8Bkgy+tcO3tAc0ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO9P123MB8484
X-Spamd-Result: default: False [-1.06 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20047-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[atomlin.com];
	RCPT_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atomlin@atomlin.com,linux-nfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6D0DE269956
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--g7euzrfwf3vjmw63
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/2] nfsrahead: fix uninitialised memory crash and refine
 fast-path logging
MIME-Version: 1.0

On Wed, Mar 11, 2026 at 04:27:04PM +0800, Yi Zhang wrote:
> Hi Aaron
>=20
> Verified the issue was fixed now with your patch, thanks.
>=20
> Tested-by: Yi Zhang <yi.zhang@redhat.com>

Hi Yi,

Thank you for testing.

Kind regards,
--=20
Aaron Tomlin

--g7euzrfwf3vjmw63
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEeQaE6/qKljiNHm6b4t6WWBnMd9YFAmmxxk4ACgkQ4t6WWBnM
d9aBqw//V5ya9/7yjQtmaeUs8DSpv9KSHCHxuM1E9iJLA8Ciui8sdCVFuxaJtq9B
NFA4uh7YG8z/HDHJbb3f9YRIX4MHX/9dXGezC9EKakOngHPoVk3LBzfzLyWUCqll
3Nu/pAShRWTwhZQQ9XwwNKPq+p2gjnYvfVU/zrJF7U+URGnMDEXmA9Qx9RUaALr9
gxfz6iE5xD2dPh/mxmZs+UK06Lxdh6SSx4vnfakPEJMFgKQRMMU09wtOtGSdxNyd
9FuPDIEFcvt3HcpAgq+/Wi59PuoXe75zbYVeUUoPNYBGHCiQFJRnOCLaoHvx47NC
/LCoLYlYQux8qhq9rqMRgr4aDmapI3cPcm7IiDZu/XzAGymS8pvhNiwHSr77YfMO
B8KukIe/j9ojzxQa0PDLNzh/X4PAkI6fl0zGpFEXHE5fTnYC/mSY7PRUgIvM2A5A
kMfCKMYNWx2DiVVZSnOuAFBGRp8lDUSEkJYQAFwKNAl1pmdPFmnDjSwineo01Uy5
YZ/XjpKmk6Dm6ZwuqQrnm/Tsf7mvS7I5I3gEokmyKvq65bBi3lraY2fMhki68b2Y
MZjvIJEF0v+Ozhm4TQys4lHaTzpBB6GXI/cUZUFvmQ8ce7ZOc3zaGy0RDdBmKuz+
7k3Vj1uAw6vkXukKrKeVSHSziDfxjlwjmG1SzK6vdJ/iDAl6ZaM=
=rr8j
-----END PGP SIGNATURE-----

--g7euzrfwf3vjmw63--

