Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3135440043F
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Sep 2021 19:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349669AbhICRoe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Sep 2021 13:44:34 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:8154 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349607AbhICRod (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Sep 2021 13:44:33 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 183GdbIM010076;
        Fri, 3 Sep 2021 17:43:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=fR1ncha/AK8HGnfJJM8PlZXOd23cA9szsU+vdNmyK9s=;
 b=WxWGKj6oyHr0O5noePKwN7bvRGps4mm/hP/2xYrtzBUXsoSbP+yu5OblzIcKBVb56Mnu
 0GLdDQeQH9XrPoMnUUMyUOFjTGbX79+GmooEn8NYG1nl+Q6a6Io1KsRu84wyC7WD0HL6
 QrTudn4fAp786EifUSlF/02+9HXz4Sr6DuzFUJNc+tmZWeQJOnokYc+VG6jNS92Vef8o
 Yb44Cy8Tf2fqI84eV2fPkHxFFiXKd/lZ3iyoL8kCE2MGbkywXdxsCHBTIEDXigyu9N2o
 4KJzDniA+zJepefIOCLNVakW9OkU3B6pm3W/MgNBkqoultX3FJD/4KQvePSHrUecJcL3 aQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=fR1ncha/AK8HGnfJJM8PlZXOd23cA9szsU+vdNmyK9s=;
 b=yzA4gz6yqO58ycqXquhQvQk7XIsuP8B0S2af2Q+XV4hublgoU14TmQ3CbpgYGXVLrXpr
 oMKoPqmmePU+19EsQe/5L76/OJs9x2JrdPeRsgciZ+R8gtmfCSQDT3d46MTPP9lrTSLR
 kxnHjSM0YAlMCIPJfo79B1+9ol9Q0Z5NkB63ixm4gmXNPfYcTjDM3pgktrSZ0cBYGTQy
 yVFuTP6+/VpsiQxk7FS8WJwq1NMmCYwjOp7PPcNyqe2cXCdpblvRDdzF9Z7RynnRM7P2
 j7rTJi+llzLFJpI+iWnoaA4/DjQJ0GT4Ax8Khlt678zCIvqJ2R9xDTR1oHakyO2RscPA hQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3aug2psjtd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Sep 2021 17:43:20 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 183HZuiV017919;
        Fri, 3 Sep 2021 17:43:19 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by aserp3020.oracle.com with ESMTP id 3aufp3m5tn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Sep 2021 17:43:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CXDeItl/thYctEzP2r4grJwtcIMSCR950vp7Zi1ZWPxcqDS21L4hGwvtj6luKXzUC8/m3pVYFiqKlnt2U7Xgek+r4HW6PpkOOE3RZHuZloE5kt0QuP2/QUNQoschBpIuz0SN7nKP6PT9xT9BQJr6223St+2j4RvVneDnU2QfvuGkZpHm5EoNcv6cXCNmVx10av39WVCnJv/3NA8rACEVtwSEC+c7PWxGmRPgJH1VWy6Xhu3i05Zlh++gRSFID8erNrbtlYNc3HTVjwckSI1RktNk4BxvGYi066XraPjI7JaCTWJnUVu3AXAeoFVE6o9DezQnWLwICPLj0qLBsCpjpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=fR1ncha/AK8HGnfJJM8PlZXOd23cA9szsU+vdNmyK9s=;
 b=fAWhEbUWquz5RIQuRC1j7rI1BjRa+G4MpcldNMrPYZENVDsRbS0QU4iAF5D6x0fXjbYWIFQMm3H1MLkOP9wGu0T5M7oOjZnlHxkw4JaENiAB6AJEaaUb6A5yWutmINUjYXsYkxeJIBKWuoLREQ5GRoFS+WW8Tfnw28LD7fvZLtGUZqp6InwI+uXgULPgilMQNtkRdgEflDNHt4FfgbpKyL/TMAUJ+W0Wfd3QCYM3FJuUX1IoNYNYvkVWD1Pzm6svn1MbjkhwcgEU/rAtngqlP81lVw85P8suofrAFGPJH1xyG4+uZlz6zyD3F8MVii3vKRv1QLRiWlqlUEH+dccesg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fR1ncha/AK8HGnfJJM8PlZXOd23cA9szsU+vdNmyK9s=;
 b=Iw1DacYF+dnjV1iukE8ww5WV5tOQm56v8Qj/cZQNhtsHsriVC8lcHQcK0zFgaTPgMyEFvQpkd2rXUAMBv67S3wBwVPkT6JrIkRrQ4lfpmaOTMjg6ILtXmczj6YshN/V/a4pSh0thRXKS6ClrY4BuLRzADqOWJ7lMrvPZcNXh+9w=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB4258.namprd10.prod.outlook.com (2603:10b6:a03:208::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Fri, 3 Sep
 2021 17:43:17 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b%7]) with mapi id 15.20.4478.022; Fri, 3 Sep 2021
 17:43:17 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "Steinar H. Gunderson" <steinar+kernel@gunderson.no>
Subject: Re: [PATCH] SUNRPC: improve error response to over-size gss
 credential
Thread-Topic: [PATCH] SUNRPC: improve error response to over-size gss
 credential
Thread-Index: AQHXn4llB4UL3nuggEqDYctWgZidQauSl0YA
Date:   Fri, 3 Sep 2021 17:43:17 +0000
Message-ID: <09190612-156D-4ADD-ADFF-19FBA6F2F2FC@oracle.com>
References: <163053903731.24419.4079441567942239288@noble.neil.brown.name>
In-Reply-To: <163053903731.24419.4079441567942239288@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 57850931-6461-488e-9a7d-08d96f025037
x-ms-traffictypediagnostic: BY5PR10MB4258:
x-microsoft-antispam-prvs: <BY5PR10MB4258F1FEBDE80182CDBE95EF93CF9@BY5PR10MB4258.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +dSthcB4BQjrfJPBffRlaZ8KH15OoyYZEJ0C0z740pHPP6xEIrSipCoNUMF7yujy/DHdphJ/UMYe64p/sNhGk92yQO6bAry5W/Tv1YNxXOSzKFHIXliP7bXjRxL/bJW7RtHoG4Venzi2QPstnapA+TiO8Tf2qYPRyUPkFZZT/YYMthdigHqT8shwOAQM5kd4i0OkmnWyH2gec7buI1rty3pIin1GveafQagFqP8MZSGwTZzIG1hcB8jDjZIDHljHtu6x+TQcnoMXI1EwihF8S6/p9VnPxBT006prre5S7BJ9RjEgSypH6WWYAKjQnXzJgtrKHLpQo+yzodmutMQ2TpcyjMhLN9is1f4esOlKUrDUrV8buxOiNmZX7riW3OVP5ZnUI+HI7+h4SOAw3CWakr4+jyXbbHqTukTFYScSKBnzJ32OQaU97x+wAuX33Mvh2zt7UswC5kHSPTFXK6UWwcDpSI1EzzSEZ+uxZxnSTKsl6pExjU6CmnFgd8kqMMBxdQpm0ARNU6D0Q18lRZJ5bTms7IoLFrzSMy0TCICuoELwBHiDAZuL+Cse1nZWb1BEPK/Iu78I72NSl9O21m5OWjYMoJ++UuGBmT0FX8XsAwzZYdNXofqN1d8VRh8cfykIbRzncFDCBDOUOkS6VvWGDssYwCK2NweyR18PiK81K+Ka8mqSvbnU9mn81kPmhMA9dmZXaK4LKJ/prrZvrDTkFWyKbCF7HTgIYbtoetP3lI9Ub/qCxiaOu7/p9f+nO9g0qE07bu/Rtzpgh9BJbnorZ5uejPZB/8qHoM2qjpuHyH1fcR3drXt3NeZFj2ofrZ6s
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(346002)(136003)(366004)(39860400002)(26005)(2616005)(86362001)(316002)(66556008)(64756008)(966005)(66946007)(478600001)(66476007)(66446008)(76116006)(2906002)(6512007)(38070700005)(91956017)(38100700002)(8676002)(33656002)(6916009)(71200400001)(8936002)(122000001)(186003)(36756003)(83380400001)(54906003)(6486002)(5660300002)(6506007)(53546011)(4326008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IsjOVAzsRwlMDsljwbsQxSE/YBFzE5aBE6mMybtAZ6rAzSPrqLi6zHw7fbwb?=
 =?us-ascii?Q?3f2GaTzZVtMX4lFawAP+ByhkgV8modLpWXax2Z1qxUmHKccwNczHHzduHsvw?=
 =?us-ascii?Q?Xp8ZOSQ+bbu3quioO1/d3T1SWZgdSuDroiGA5UjFm1FTXK/I9gX5UcAmboQN?=
 =?us-ascii?Q?3Z5JmkyEiVUmdHsybJWurPEJiYOrs9O9FrFiMGIZSBRQzKph3U60LxcbDsfB?=
 =?us-ascii?Q?6otixizZKaBbTYP2qAXQ29aHYVsku0SLx72RTnJZA/B1F1uJu3jiI6sAKwaZ?=
 =?us-ascii?Q?TWhKGwuRg59s/YEZhjYP8vlBCzTGdtDnb+R7SacxzI6Ykq549y2ccWQu2rRW?=
 =?us-ascii?Q?epxathIfLcfKxNQeOVvxzE8l0kejF3/7/aDen0KvmKiWWi5HJLbHyYpuCwII?=
 =?us-ascii?Q?IO1Oy2+DLEpNwUiH8JR8EEKp5ElMkCBwAGzZidkqN7wabqAP/jVzySLIa7E8?=
 =?us-ascii?Q?GG6vDca6qlF7CjfxFqaIfr4vYOJrNnUTRFQ5rN9jpC4R6W4zvOMDhq5yXz8P?=
 =?us-ascii?Q?qdKaE9hmMTApgOEcxqtLRIAF0EYPBLDdSyuw+AQJMOmkdeeoeKaggzIflfTA?=
 =?us-ascii?Q?BS/D2UesYyU6LxpqQsFnirs3/bQXkRxKf+Pc1W9XfqSf+46DyU8iFlDAJtBV?=
 =?us-ascii?Q?Oq2HTBqgYv0Ua+nwgPafdiYZIQbGHDdJ2wUYXLWVG4yX4b/xfpZ/FHUQmgxj?=
 =?us-ascii?Q?5CvaL5IJo/k8/VXnf7FyzEzMx670Y2NSlVax0QZlJxNlsu9sEBIc9HR7RdH3?=
 =?us-ascii?Q?8PW1+evlzI6RJUIqFD1qSFM9+V8U1o0EPNkWSOL/4vlzlPdxAUqm0rIzoaI4?=
 =?us-ascii?Q?GZkGX6GojUN0wjl7ERESxndwXtsh+DjBKeS3y4fvFbEODquNB6EvLPFkc02/?=
 =?us-ascii?Q?hhV+BIz0BlMMW7NOO31HXuv/Ula2RDhuCbon98SjwAFp+GxQD+XKvRBE0lQY?=
 =?us-ascii?Q?aw/KM8zCnUUC7UIEuBlRrDpz9oLvyi3sXmqmYHKqqSrpnMac9wjbdgqetVGy?=
 =?us-ascii?Q?1wZuB+sp50b1wduKKe6FiDC3JFvavNdtfVtu5YHctssYOP6k2n260picYPsV?=
 =?us-ascii?Q?y3Jg0mVpMAZ3qIGAMtG75nQJqCkYoj/JJie88chqMheJMfZVxpViKZZ52ovH?=
 =?us-ascii?Q?CmW3pZb1q5JzrSnSYt/XMZ1X9aDkjZ7clf9E+1PdqtoRHf0W8tBrig+KFzbY?=
 =?us-ascii?Q?bucKfH9MQybY7CDfuhqZrRx5nmWRoZ8cfyUZ5NfrrfRNabEqPeMQZ4sHibHG?=
 =?us-ascii?Q?rC3njyauMFrthkPrOBpe8SMtWU7N03/pK6NTZ+yskz4So1xEyWBPl3f519sF?=
 =?us-ascii?Q?5PcgiGChbqk571+jZBGrJpqT?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <933B2F6DC8A5D84EA744F9D47D67ED1A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57850931-6461-488e-9a7d-08d96f025037
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2021 17:43:17.5537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QYK3BXcFruXiIEALGGC39Iv+3JTc7SMAV4mNPiskSF+CD3iK6vSq6kmZ9PDMR1syLTTwPtiIl19RAZGOk4yjrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4258
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10096 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2108310000
 definitions=main-2109030104
X-Proofpoint-ORIG-GUID: oAmItlkDWms4tUiaMsuVcuR_mQB5vJCf
X-Proofpoint-GUID: oAmItlkDWms4tUiaMsuVcuR_mQB5vJCf
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 1, 2021, at 7:30 PM, NeilBrown <neilb@suse.de> wrote:
>=20
>=20
> When the NFS server receives a large gss (kerberos) credential and tries
> to pass it up to rpc.svcgssd (which is deprecated), it triggers an
> infinite loop in cache_read().
>=20
> cache_request() always returns -EAGAIN, and this causes a "goto again".
>=20
> This patch:
> - changes the error to -E2BIG to avoid the infinite loop, and
> - generates a WARN_ONCE when rsi_request first sees an over-sized
>   credential.  The warning suggests switching to gssproxy.
>=20
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D196583
> Signed-off-by: NeilBrown <neilb@suse.de>

Thanks, Neil, I've queued this up for nfsd-5.15-1.


> ---
> net/sunrpc/auth_gss/svcauth_gss.c | 2 ++
> net/sunrpc/cache.c                | 2 +-
> 2 files changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svca=
uth_gss.c
> index a81be45f40d9..e738c0182f09 100644
> --- a/net/sunrpc/auth_gss/svcauth_gss.c
> +++ b/net/sunrpc/auth_gss/svcauth_gss.c
> @@ -194,6 +194,8 @@ static void rsi_request(struct cache_detail *cd,
> 	qword_addhex(bpp, blen, rsii->in_handle.data, rsii->in_handle.len);
> 	qword_addhex(bpp, blen, rsii->in_token.data, rsii->in_token.len);
> 	(*bpp)[-1] =3D '\n';
> +	WARN_ONCE(*blen < 0,
> +		  "RPCSEC/GSS credential too large - please use gssproxy\n");
> }
>=20
> static int rsi_parse(struct cache_detail *cd,
> diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
> index 1a2c1c44bb00..59641803472c 100644
> --- a/net/sunrpc/cache.c
> +++ b/net/sunrpc/cache.c
> @@ -803,7 +803,7 @@ static int cache_request(struct cache_detail *detail,
>=20
> 	detail->cache_request(detail, crq->item, &bp, &len);
> 	if (len < 0)
> -		return -EAGAIN;
> +		return -E2BIG;
> 	return PAGE_SIZE - len;
> }
>=20
> --=20
> 2.32.0
>=20

--
Chuck Lever



