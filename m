Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E89A414D53
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Sep 2021 17:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbhIVPsv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Sep 2021 11:48:51 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:49338 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232318AbhIVPsv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 22 Sep 2021 11:48:51 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18MF0vt1013132;
        Wed, 22 Sep 2021 15:47:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=OXbkqqeBJzZpLT51alsQqwAezFA7ar892n1I+zhp/dM=;
 b=YeaugeP8qDMRfFwJVe4uzDq7F2g8TpCj2VkuHBPGvnQmEFSIwCiy7X4lWupLsjdk+y5M
 f1mfelU+p5DEQIZUYaeFNnFL8HUUBYAmQgW/J9XO/LxMWLlD1DXh3z59eXV0P7PXRXPC
 HMsh9UmTPQHIC1RNKVl9O/zkKgl6/s8m1RKoIxCXhThUdyXFxviZt6TuZLt66U5DIDod
 /YVtYHw/p3OiJWU95H4FFad3VEPKECFavn5wrx6jfQ0zsqsMdAOvct6S0vgsgjlqsorG
 ygI7eJxwlD3v9/F9+1nVJg6sbjqXNIdeW3vO4DLJWTC5AVGCypWD/GfVxecGr41vr31W 4Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b7q4qmvdt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Sep 2021 15:47:18 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18MFkGRo154826;
        Wed, 22 Sep 2021 15:47:11 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by userp3020.oracle.com with ESMTP id 3b7q5wdvfe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Sep 2021 15:47:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DiH1Rw6r5V53nnf0sKMv8FqVg0jOShpVp9wZqONmWHktuCr/H/P1/qUaCmqOkTshR7woG6HHy7sVqr9E6+5pe8PKW3TM0ngwXLFsFfvpAdyfpccJb7zTKqWZT8qcYK89DzpsA5HZGacUjepVW0oVNgfh2EIULYzpodm8NQpe8kE5Fk9x5vuMExmmbQWBOEXtlzmid/Rdy3hvjurav052r/k3/YHYtkxQ8I4xkJBwWle2gGdwmjuEcqVHmDWpsZeF91XK89VRyF4bSLZ3nCEk+B3v17yxdQF+qszfZ+BxFKBQ22LiceHBPOJ3dtf8gUAOaJjfQlGqylUk0sihgKVUMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=OXbkqqeBJzZpLT51alsQqwAezFA7ar892n1I+zhp/dM=;
 b=EA4P6x22PDvKJsvYSFrLra28ZBbFDBNSrt+Uq0G7mS9M14DG0QFynBHgTfRY7KoMSyCYtzjaMsnMKDtW/pAj89PNOlyQasSbpMaH3fyu5ZsfAkNJk7A/e6p+H0J/2vBm1T9Fv8NXmeJDuHdvAxcRYaS6sQAsoQ+yHWE6xtXU39f/UptwgtyzYRJ3BQ9XZnSD9wpP/saFt3d2rHBXWQVLyoWjLvx3+j6J0DjVfhFOlwWVxwWi5KOD5wfkEzZ2ifknXwOJKjBgRpHpwiZWe3G40eVrT6+W0WTqqKtupurPQ7566/w1S3Figl9BSYkz8lqtA/GTdGlemYHaknBN+adSEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OXbkqqeBJzZpLT51alsQqwAezFA7ar892n1I+zhp/dM=;
 b=Jsw/hGoDUTZxxaLoz8SoVjmHe2t8GPh3FkAb6QAQfkKBdGdQPUXMiKydIsNU4YpNfe/pX7AKW2LLOR07UNsCOWisQlqX2LfNOwUo1Bpkux/vG4KninZQFbaJ/0ssA/R0N6gYO3ZPvl6WIIvyGpCxIwXVqpSpu1wKzpXF/olfEww=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB4210.namprd10.prod.outlook.com (2603:10b6:a03:201::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Wed, 22 Sep
 2021 15:47:09 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b%5]) with mapi id 15.20.4544.013; Wed, 22 Sep 2021
 15:47:09 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Dai Ngo <dai.ngo@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] NLM: Remove svcxdr_encode_owner()
Thread-Topic: [PATCH] NLM: Remove svcxdr_encode_owner()
Thread-Index: AQHXqy2WsD0fmjmgOUmW4+O/YnSBBquwO3mAgAAAXgA=
Date:   Wed, 22 Sep 2021 15:47:09 +0000
Message-ID: <7533B3B6-9128-4380-8209-6365F5DAF079@oracle.com>
References: <163181894199.1110.356714948732645250.stgit@bazille.1015granger.net>
 <20210922154549.GB22937@fieldses.org>
In-Reply-To: <20210922154549.GB22937@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: be1cb471-6ced-4c25-dcbc-08d97de03cbd
x-ms-traffictypediagnostic: BY5PR10MB4210:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR10MB42104EA3E9488952159BE84793A29@BY5PR10MB4210.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 00ZCqr8s6wIwSvC1aQzFnDgaZqZCqlF5FCc32ErIesbbVuU5uu45z766dLZA/p0KGSOvxq3pEFUFLSW4F9Pv96ejTcYg8crCfEiJr89Sk5YMHWY/anewSM4Y26pJCYMpeA6hc3TKaTftyPjhY3IRitl0j6bI6P57ip6EqkaAW3qPLu9wgu1v6XcPPApbpCRkMg2dXns0Xn4kz55BhuhPe2CPIuAFeVIz0aSvWmmlKy2/28QrEjD0UanPEPQN+KKyKDo8aSdr2KGp5je7+K1ifYczkitrzjAoJ9t8FETusVQpbzjd6DYiDug5NBZPhGuLI5tJJ3YKotgIWVGLPtPJXXJ9ZF6kxhqfhRnS7OwgKgjNCt4dR5s9DFA6eWTAwnY+65X2+0k8Tm1enE6sNh3+/f9JEdyWDb+8jX+5VdUBC/0KA4PvVxm36evm6yV3Pqpx884Jum1slQorKefLauuZaFORQjw1L4jtUV8zGuyAICwoeGyVhJgEHCwdHx685YEa1s1fNwKf/ySlgqkcWCSAd4pGNUhTOh1GcjJyqFmb2p8X4155ompxsBM/XMNjt/bp5QDXJoq2BUo7cw80TVvP51RHeGc5nWRW4ifVrEp/J1S9RKONkgirh3fLnCOOL4r00RkCDldWI1iGI+rG+wgE15XMIlVfvZr7QI/YAIzhwO/sjIlTq1Cvq/90Gv6HAbzT+zQUxvSf9JeBtWrjJ8XNK7yOO+h/XId8ISmGZnYyzKCpYJnPNFIoPu9Sz1SgUbkw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6512007)(33656002)(2906002)(66556008)(64756008)(26005)(66476007)(2616005)(66446008)(66946007)(38100700002)(5660300002)(8936002)(83380400001)(508600001)(6916009)(36756003)(8676002)(122000001)(6486002)(86362001)(53546011)(6506007)(38070700005)(54906003)(76116006)(186003)(316002)(91956017)(4326008)(71200400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nskUIvKsxeCvdGVGYTvaoMGkC30WRTKFjWFC8e47DBOkr7qA/gOb5/O/Vjzj?=
 =?us-ascii?Q?LXjswlWJc6NtrHoVaPSaaXuzsvqzpjt+YyGo+YSEOQ7UR3uggv9/5C3PEB5L?=
 =?us-ascii?Q?Oa1p0NKTFPmgn0fo35mzdWOLfEjRdP9YadaMF1m1q584NuxbnhO1wO145ceT?=
 =?us-ascii?Q?uuyUNaK7dkb/SHgYLKNoowO8tVh6sz2ew6Ben6KNQoI+xd8xur0QBU5mwRtg?=
 =?us-ascii?Q?VfA7obKDlj04Ui5uxo+GD1lsgP2+CXrRnXsK3/kIpTW05kJm5b7/bEnRk6Kd?=
 =?us-ascii?Q?jrcm6kPB6iFbRQ7HjLMyDpOJIWrYgHzhS6GEsuyOhuReFZbdT9/fWEb5MUrT?=
 =?us-ascii?Q?70Y1F0n7xQCTmWw7zBvlmg4CQGgAvV+7lZoBFX3cnGePf4h2SnTJXGEpjANo?=
 =?us-ascii?Q?rvBd7MabFnJuq6SNLi2VP8DigYajxGgawWuAUtc72RILp4ORc8psi1lKDNaT?=
 =?us-ascii?Q?w3cYVHB49ZCgjaTcjv4j8dM5TYkMtNUMpsYsmgR8+Ppsy1zyp2+NVPrBfk38?=
 =?us-ascii?Q?UyKOkTTPOKGJ4pu2mXGYtyTpPv5cRvbryO0yV5cmOFp5L9OrO2vOH8mEZPiq?=
 =?us-ascii?Q?tx+HI0bt9gzQS0UJzZes8sZT2cdQjMO6HoeQ0suLlyFvnASuWHVapGcN1tHZ?=
 =?us-ascii?Q?U1t31z6ytQN0krwiIlzdgty61+Obc3mB323he3rScFKvfvjzYI54Q8Z8E7+B?=
 =?us-ascii?Q?sWzLcIvUibbnJOF8Ir6/sbAaEUG1x8q0kdfe+xOYSk9Rnwmrdxmr9MFY26Xs?=
 =?us-ascii?Q?MVoLbS5ZOxHiSUxiL05tnmC5WsgWhLpU1P/fUSq2kYm2sKlibFt9FW5ajTAa?=
 =?us-ascii?Q?veN253ojvnSjb8gODZwLUSHv7Vq/BPAoYVg3G5RusG16eP5+nTnuifh0+CwM?=
 =?us-ascii?Q?QB0x+S5AfXPc+H2/4GWh2p5hCzrgTlFeMppNIY7Jkvw1qbR7OkP3ldfYvC6c?=
 =?us-ascii?Q?9WeRFq3IoGSH065djohzfKtDy0rdgI4fC6DISgVWWZaJD0IV37xuICq7uxwU?=
 =?us-ascii?Q?wlZ4A/8FQSpX7QxcSr8AOqYCDuqC5wWPx5mgHk1BDuzRNIRGnFgsPFZTgZvI?=
 =?us-ascii?Q?aX1wCxu8JLfKPnQNDLe7mCc/wB/PYzTLjYWduEl9qMzjh0FP8z/uxl1bXSrA?=
 =?us-ascii?Q?tLaAw4XgwrdbMm7Qs8d2dDKDg9fgOOLziRvzDiAe9NPrmvAewWgHQTeKgsOi?=
 =?us-ascii?Q?x90iWIVMXmNXywzcV3MxA/9z2ysA953IiAl4WQ7sYqJhMuWeOZXUUrfcmz4X?=
 =?us-ascii?Q?Axpxw8ZAeIERFot/59YL3zlGVXsFJBcGHQJ8fHx1SwDE8S0LFPJq2Ny71yu+?=
 =?us-ascii?Q?MEPbJcT88jzZoJJR66UYvvei?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <94655AAA9319BF489BF9FCC3B7063792@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be1cb471-6ced-4c25-dcbc-08d97de03cbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2021 15:47:09.3872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IFRydpYxqd5ZguBYHPCIoHDM25qnJy+/xkF5nBs6LmOdhDs5oJ1TqIGPm22vDeJa1f7FDHSJS6c2T2RCahLthA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4210
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10115 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109200000
 definitions=main-2109220110
X-Proofpoint-ORIG-GUID: nWQofEW711M1WJGnZzWcLvM2jBVNHa0_
X-Proofpoint-GUID: nWQofEW711M1WJGnZzWcLvM2jBVNHa0_
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 22, 2021, at 11:45 AM, J. Bruce Fields <bfields@fieldses.org> wrot=
e:
>=20
> On Thu, Sep 16, 2021 at 03:03:32PM -0400, Chuck Lever wrote:
>> Dai Ngo reports that, since the XDR overhaul, the NLM server crashes
>> when the TEST procedure wants to return NLM_DENIED. There is a bug
>> in svcxdr_encode_owner() that none of our standard test cases found.
>>=20
>> Replace the open-coded function with a call to an appropriate
>> pre-fabricated XDR helper.
>=20
> Makes sense to me.  I assume you're taking this for 5.15.--b.

Yes. I'm just finishing up testing for the next -rc PR.


>> Reported-by: Dai Ngo <Dai.Ngo@oracle.com>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> fs/lockd/svcxdr.h |   13 ++-----------
>> 1 file changed, 2 insertions(+), 11 deletions(-)
>>=20
>> This might be a little better for the long term. Comments?
>>=20
>> diff --git a/fs/lockd/svcxdr.h b/fs/lockd/svcxdr.h
>> index c69a0bb76c94..805fb19144d7 100644
>> --- a/fs/lockd/svcxdr.h
>> +++ b/fs/lockd/svcxdr.h
>> @@ -134,18 +134,9 @@ svcxdr_decode_owner(struct xdr_stream *xdr, struct =
xdr_netobj *obj)
>> static inline bool
>> svcxdr_encode_owner(struct xdr_stream *xdr, const struct xdr_netobj *obj=
)
>> {
>> -	unsigned int quadlen =3D XDR_QUADLEN(obj->len);
>> -	__be32 *p;
>> -
>> -	if (xdr_stream_encode_u32(xdr, obj->len) < 0)
>> -		return false;
>> -	p =3D xdr_reserve_space(xdr, obj->len);
>> -	if (!p)
>> +	if (unlikely(obj->len > XDR_MAX_NETOBJ))
>> 		return false;
>> -	p[quadlen - 1] =3D 0;	/* XDR pad */
>> -	memcpy(p, obj->data, obj->len);
>> -
>> -	return true;
>> +	return xdr_stream_encode_opaque(xdr, obj->data, obj->len) > 0;
>> }
>>=20
>> #endif /* _LOCKD_SVCXDR_H_ */
>>=20

--
Chuck Lever



