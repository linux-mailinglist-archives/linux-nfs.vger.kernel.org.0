Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28231602D3C
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Oct 2022 15:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbiJRNou (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Oct 2022 09:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbiJRNot (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Oct 2022 09:44:49 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9BD4E87A
        for <linux-nfs@vger.kernel.org>; Tue, 18 Oct 2022 06:44:44 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29ID4OaC015573;
        Tue, 18 Oct 2022 13:44:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=/HgVGUlLv2bo0n2qolUw7bxere6KmVYsjZWCEPS5o4o=;
 b=nWH0bh3X7PBE9PlrQFi0gtUstE56eD0UaX/VBi4rBQNxVpx+Z5ALdRs9U2m29M+pJ5tg
 vQvjpxfJqn3s8F/KrLKKVUkPpmtScFQ9yIvMzrKaVG9XBocNx3fsfNTMhlacVEd40Yad
 +ahbQ8YIOi3B+0QdHKHHRjN30iovD5rl+LxEh/HVAC5+DFYcd87G7pR1s4biPfbtLY13
 suGQY2QNgVaYMjEwxh2BhY+mLZlSRGBOqca7L3ML86pH4fhVbrdmZFp5MRRfBzpbl/3R
 VC79KzcF4wFjE7F7l9puVMfCH4XJOlMHor0rALN7WtOk8N5uBVJzoMBwxc2pQRFLWDM1 mw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k9b7sjbq6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Oct 2022 13:44:36 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29ICe1n8024261;
        Tue, 18 Oct 2022 13:44:35 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hu67epu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Oct 2022 13:44:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J4r26w/AVJ4c/pXADBpeD2+z62WxvKT1/xMJlH/GGGvc4csFLwvy48whVHsxW9iA/yuWtEMTauDN9sJhWxpEDAugJG3izC7D3gP2a7k7KduyQ0pgAMECYfyDxVpA4MHlV/yTOIejwg5DV4ZEi9SEZziK+4sXntuda4Vp9uyfgqQziYjrUAXmewj6NzIVb8ckjSVR52TLAKURqmdFpiWsdNECZGVclg9zW9l8wud8hj1XVbW+P0aa/XaT+Z2rYMMedfWKuka+LMyndtcGEz3dhBCKBsyu+quJWrVzLPYo/rFiV3M8CwVQNj6gqwoGDgXVA0VZENiUXHjR2YGD9wDyAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/HgVGUlLv2bo0n2qolUw7bxere6KmVYsjZWCEPS5o4o=;
 b=VQvSYEt957Ifh+WnicCNSHA2Unod2u3VQPSedomoCkzrBAjpa+6wRNrD0GkuY+lsXOeC+JW0x21lbPtKNYWrnsedv9huxjvWTT4dbyjXT4l9mbmWt4U7c5mkGOuhlqDLbnko4aEwCU9FBf1K07iaUj1B50gnCWNzBDLMZSbjOcCYtETV0KE5fENTC1nMkIx8OfN08pAZpV8jU7eI+DvP/KLcySElNVOhAuJaS9nonR6lNBKpEQgSfNWmtu3QVAZewWwMFxWy8mYzDJh1K2fthQJmoP3MSjWtFFIwJ4HF5bnyW3ELEPqBrIfmPZ+yhM88pwn58lpJ9CxMok1UEGFiuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/HgVGUlLv2bo0n2qolUw7bxere6KmVYsjZWCEPS5o4o=;
 b=pWOrSiBsAkrE9LayoIg45qmFD+1udhirPA7voTSRiL95ydF0DaKL5qV/vgMqMs/BsCurUZZqDq83aXRacuibY8uyLalpL9Q5y2fISRYDno/Lvxzadt+7TOJwonLTffEjES7DjFf4tDp+93DBh8RyLdxO9XKIt9a4pnSpHQU0mCg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY5PR10MB6166.namprd10.prod.outlook.com (2603:10b6:930:32::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.22; Tue, 18 Oct
 2022 13:44:33 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%4]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 13:44:33 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        "simo@redhat.com" <simo@redhat.com>
Subject: Re: [PATCH RFC] SUNRPC: Add support for RFC 8009 encryption types
Thread-Topic: [PATCH RFC] SUNRPC: Add support for RFC 8009 encryption types
Thread-Index: AQHY4mpNrGmLrsQCk0qVLV+QqCYw264UJdkAgAAE0wA=
Date:   Tue, 18 Oct 2022 13:44:33 +0000
Message-ID: <813B9492-DD07-4D19-A94F-A536BDDFE953@oracle.com>
References: <166603945959.14665.12642421516208884.stgit@manet.1015granger.net>
 <f39180dcf51e2fa63ef61898cb0e046152b12558.camel@kernel.org>
In-Reply-To: <f39180dcf51e2fa63ef61898cb0e046152b12558.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CY5PR10MB6166:EE_
x-ms-office365-filtering-correlation-id: 696f2ffd-f2c3-4e8e-92f9-08dab10ee39f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gevEJmjUNOkHCQo8bjPssNU9vdDS4pKIhrw6NriMaxt2DlOM7fK7TdtmCu/h5+gO9lguEJHN4EJ3748RB/UU+G8JmXrEFQyaO5VVtdI7qXQHHvyByaT/vhOk8VokQV4ZjcAINydDTKbRsIPO/vaJ4c4NVBfLBQxmSTz9HIph0z4+dKNByoqPu981dpnZbipVfo9V3bhQlCzDxv2vHmzT+ZBoqQAsSsQG1gDU3vVo3Ai1ThsujG2RzMABtjKlBPBs5MFd/AAGILO2T/7JXnNoYtav2KmQrvYvHaSM1uKDANRql0QIrgfa6CfjzbxB+714M2G93zqCaxbQdVYX0nj+FAMsfTDSHcRy6avTgGjZnEQr0+9keq9y1WodNcRMCnE4t+fD6Tpb5lBH97Fx/GGVkWeca56dilkEs3GCsYBe3nLaEkZzuowHMxswl4PmBCFZumUfZJ+LdYVyzjr+2gxDWZ4c3/6Smx4+zFw9TBh7eqrovkBgHjKqHMZkoZ1o0IT/Kc7qWjhDZdsy2FbqrQ2TWLEFQ6R0PorGFjf8PuTVQVflge+6Ns9tl2rUH6IbWMsWfJqMzK3ZALnNRxkfYv9hv5xUWRmH/KpUzG4gOHx/tsu5rsBYz/lAUg/bjXp3/QFUidrTU09DDiEHyHsEc4Kn7J/je72nd7IYUHNfqRYWI0Yi3lBbU684zXhKEmhPS+ZY0b/ClGvkvhev+XlhREWKsxGFMPEZaxgD6xyRG0f4OTJh5jf0JhqryWh98dBQP0JN+bFVk1xih+QvHOPQcwgziViNuz4jP506KFTQBlwgedCtsweIZJ+65Je0KvOq+yo8x49H8MHSK9Zsn9aGHsoOt2twc8DQjZ81GqvW9efet5urqBuTgQIFexL8OOTctNb+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(396003)(366004)(136003)(346002)(451199015)(45080400002)(966005)(71200400001)(53546011)(6486002)(478600001)(30864003)(186003)(64756008)(4326008)(66946007)(76116006)(66556008)(66476007)(66446008)(8676002)(2616005)(91956017)(41300700001)(4001150100001)(8936002)(5660300002)(38070700005)(2906002)(26005)(38100700002)(122000001)(6916009)(316002)(6512007)(6506007)(83380400001)(33656002)(36756003)(86362001)(54906003)(21314003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DjhfjjoaXoNLeWmUPGC6deBp0xPizrO7ELJyn71eJqt06bRPrhabjfTGMf4t?=
 =?us-ascii?Q?wtrnZ+XPqx2Qx8j4DaUSufzoE8yqX9vFO4HXqdMGklpnngrP+onVyDLMlfbj?=
 =?us-ascii?Q?582f28/4Hrq3fvJpKm86GQg4o7EUXZsstzJCBKL+bYXvdpki9k4fkeYNsxCm?=
 =?us-ascii?Q?M77yDz2MbylPvGjTYgGZoKcDUk2obnc0u6h/iaGK5khbuVOus7D62/5Rz9Hk?=
 =?us-ascii?Q?ec2iKq/r7mfw9JnQzLCdv5yjHwfqF/4zBlFJNAWJ5NaPWyDmgfbzv6p4gFG7?=
 =?us-ascii?Q?FSM5OLUzgYT29/q7jDA3QnqO6YcQXlzpqiaiLrhhxCn5j1ccmmV5mzwa5quh?=
 =?us-ascii?Q?eMupWGxVmYI8EmpYWw+xpj/Le1ZJ/7yRxHjmaTEjqG1clv6rXu7NC0zjT6wN?=
 =?us-ascii?Q?s27ODR4DBazCtctnjnPrNQlZCExYC84oxTtpdb6VtXDb3o+7PGhkV9c7D6It?=
 =?us-ascii?Q?jcYuqx/457j5yQYT/7Um0PgqaWiEm1j2wxUCFCzSYxIFVqjWXi1Bs47UdrGb?=
 =?us-ascii?Q?7rE3nw/yUohu3TuyxK0lPNaj0ySZxo4RnhHCnaO3bjqi9PuRttHpXLDEDO/o?=
 =?us-ascii?Q?b5qNP5S7SffYr+fUaza/QvV/dOxz/+7PDxwjaXpzKTtKaDVsVnx5EEBYDFcY?=
 =?us-ascii?Q?lt3V/A17l7MvZwteC5/ttExbiYJ61LBdeJsjGP165meEFl1hUmuVFZcLC5mc?=
 =?us-ascii?Q?oNY1jDRSZ82CYDBNZKYh/czAgmdV5uu0xzA2BcKNoxeuZiK9p8OR4C0W6pNG?=
 =?us-ascii?Q?LdYWJiqzzBz/GcQQpHLuSYMGk8wibe4wiYR09IL2XLzwjftOSswQkT9ID2Qq?=
 =?us-ascii?Q?1n0HCHwwIjHp9cxKVjwhaSXs1Huj6HDe5BEUhO0UHmF1GjmnldKhz1MAEH5E?=
 =?us-ascii?Q?NgYlabrazhV0Y6w3SJHvOsvP3dObE0DC43X5XVyTneGLNH2soZIOpUxETRVv?=
 =?us-ascii?Q?BkUt39S8srnW5I5gD+EKr8ZDCwLCJUNWDvQOJjy4R6cqul15AE0bYGwMBv/U?=
 =?us-ascii?Q?yAgKXjFLlSSWOa/DEel5Nu/zjdNgXc+Ozw8yV4ZSXOomi3gWadWZxqNoIPK4?=
 =?us-ascii?Q?Z6CxmwU+OTRQuC+bIGKV2dtUfKNTWSd/xz/OYqv2IvFMAMioHEioTl7AgWv+?=
 =?us-ascii?Q?wAGhjYTPmhP97ek4ZE/8Dp/43CSPeh4YJM46NMENjaUUhodbXmd8QRqbc0Ud?=
 =?us-ascii?Q?0B1cG48FI6uSQwn5bwK972SRxAOm4mkTbir1aYb/EWCY19/H6jPCEsRVKID6?=
 =?us-ascii?Q?H48wrzXvG3M3CkAlC6ZfiNh5Y7aQCsAcrJ5rA60+6OIedgsK5HuzDPfqkEWV?=
 =?us-ascii?Q?trUdXcsUiTBmVUZgwSY3HslclTzaNxGs129MkRGXAe1upCWgJXLxFaqUhStx?=
 =?us-ascii?Q?8qlH6ZZ5THAR9pQ3T+h07Kn1lfLg8k+4fSNKc/nh3hJ+9iHEtPwoZxh65Yz8?=
 =?us-ascii?Q?PHxPyAWyEfsBsX3tyOmpdGXdoBN8Eio1qxYIpjt1Xp0CWgCOJ3d3AbniZvzV?=
 =?us-ascii?Q?bwiVfEo9BIbdhZ9wdZs+ZdWMF0/wJGDeyW+rCTDoYEvpQ3Adi5UuCpzpNZ+e?=
 =?us-ascii?Q?v88/oJMbDsZIP4xp9WOBG/FbudKw47VTqVcLTPSkie1iWtrHRQ/I4dm7zjDY?=
 =?us-ascii?Q?OQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FFF974803E35E1419615CBAE163072CE@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 696f2ffd-f2c3-4e8e-92f9-08dab10ee39f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2022 13:44:33.2578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rattR3ydaFc7BAukufCkVweMkS01trZHHaaH3YFmJqKOXnLDnI2csLJ15srVBTtHhFczEFDHOIXYLveOqSAsqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6166
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-18_04,2022-10-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210180078
X-Proofpoint-GUID: VDUkVJQE0oXAf8zCTqrKiSeJXffg_DEM
X-Proofpoint-ORIG-GUID: VDUkVJQE0oXAf8zCTqrKiSeJXffg_DEM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 18, 2022, at 9:27 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Mon, 2022-10-17 at 16:51 -0400, Chuck Lever wrote:
>> These new encryption types provide stronger security by replacing
>> the deprecated SHA-1 algorithm with SHA-2 in several key areas.
>> There already appears to be support for these new types in Linux
>> user space libraries and some KDCs.
>>=20
>> Quoting from RFC 8009 Section 1:
>>> The encryption and checksum types defined in this document are
>>> intended to support environments that desire to use SHA-256 or
>>> SHA-384 (defined in [FIPS180]) as the hash algorithm.  Differences
>>> between the encryption and checksum types defined in this document
>>> and the pre-existing Kerberos AES encryption and checksum types
>>> specified in [RFC3962] are:
>>>=20
>>> o The pseudorandom function (PRF) used by PBKDF2 is HMAC-SHA-256 or
>>>  HMAC-SHA-384.
>>>=20
>>> o A key derivation function from [SP800-108] using the SHA-256 or
>>>  SHA-384 hash algorithm is used to produce keys for encryption,
>>>  integrity protection, and checksum operations.
>>>=20
>>> o The HMAC is calculated over the cipher state concatenated with
>>>  the AES output, instead of being calculated over the confounder
>>>  and plaintext.  This allows the message receiver to verify the
>>>  integrity of the message before decrypting the message.
>>>=20
>>> o The HMAC algorithm uses the SHA-256 or SHA-384 hash algorithm for
>>>  integrity protection and checksum operations.
>>=20
>> I suspect that the third bullet point means that some code changes
>> (rather than just new encryption type parameters) will be needed.
>>=20
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>=20
>> The purpose of this RFC is to figure out the code. Testing and
>> resolving interoperability issues amongst clients and servers that
>> might or might not support these new enctypes will be the next step.
>>=20
>> This patch has been only been compile-tested for now.
>>=20
>> include/linux/sunrpc/gss_krb5.h          |   16 +++++++++
>> include/linux/sunrpc/gss_krb5_enctypes.h |   22 +++++++------
>> net/sunrpc/auth_gss/gss_krb5_mech.c      |   52 ++++++++++++++++++++++++=
++++++
>> net/sunrpc/auth_gss/gss_krb5_seal.c      |    2 +
>> net/sunrpc/auth_gss/gss_krb5_unseal.c    |    2 +
>> net/sunrpc/auth_gss/gss_krb5_wrap.c      |    4 ++
>> 6 files changed, 87 insertions(+), 11 deletions(-)
>>=20
>> diff --git a/include/linux/sunrpc/gss_krb5.h b/include/linux/sunrpc/gss_=
krb5.h
>> index 91f43d86879d..72ded91b7a86 100644
>> --- a/include/linux/sunrpc/gss_krb5.h
>> +++ b/include/linux/sunrpc/gss_krb5.h
>> @@ -150,6 +150,12 @@ enum seal_alg {
>> 	SEAL_ALG_DES3KD =3D 0x0002
>> };
>>=20
>> +/*
>> + * These values are assigned by IANA and published via the
>> + * subregistry at the link below:
>> + *
>> + * https://www.iana.org/assignments/kerberos-parameters/kerberos-parame=
ters.xhtml#kerberos-parameters-2
>> + */
>> #define CKSUMTYPE_CRC32			0x0001
>> #define CKSUMTYPE_RSA_MD4		0x0002
>> #define CKSUMTYPE_RSA_MD4_DES		0x0003
>> @@ -160,6 +166,8 @@ enum seal_alg {
>> #define CKSUMTYPE_HMAC_SHA1_DES3	0x000c
>> #define CKSUMTYPE_HMAC_SHA1_96_AES128   0x000f
>> #define CKSUMTYPE_HMAC_SHA1_96_AES256   0x0010
>> +#define CKSUMTYPE_HMAC_SHA256_128_AES128	0x0013
>> +#define CKSUMTYPE_HMAC_SHA384_192_AES256	0x0014
>> #define CKSUMTYPE_HMAC_MD5_ARCFOUR      -138 /* Microsoft md5 hmac cksum=
type */
>>=20
>> /* from gssapi_err_krb5.h */
>> @@ -180,19 +188,25 @@ enum seal_alg {
>>=20
>> /* per Kerberos v5 protocol spec crypto types from the wire.=20
>>  * these get mapped to linux kernel crypto routines. =20
>> + *
>> + * These values are assigned by IANA and published via the
>> + * subregistry at the link below:
>> + *
>> + * https://www.iana.org/assignments/kerberos-parameters/kerberos-parame=
ters.xhtml#kerberos-parameters-1
>>  */
>> #define ENCTYPE_NULL            0x0000
>> #define ENCTYPE_DES_CBC_CRC     0x0001	/* DES cbc mode with CRC-32 */
>> #define ENCTYPE_DES_CBC_MD4     0x0002	/* DES cbc mode with RSA-MD4 */
>> #define ENCTYPE_DES_CBC_MD5     0x0003	/* DES cbc mode with RSA-MD5 */
>> #define ENCTYPE_DES_CBC_RAW     0x0004	/* DES cbc mode raw */
>> -/* XXX deprecated? */
>> #define ENCTYPE_DES3_CBC_SHA    0x0005	/* DES-3 cbc mode with NIST-SHA *=
/
>> #define ENCTYPE_DES3_CBC_RAW    0x0006	/* DES-3 cbc mode raw */
>> #define ENCTYPE_DES_HMAC_SHA1   0x0008
>> #define ENCTYPE_DES3_CBC_SHA1   0x0010
>> #define ENCTYPE_AES128_CTS_HMAC_SHA1_96 0x0011
>> #define ENCTYPE_AES256_CTS_HMAC_SHA1_96 0x0012
>> +#define ENCTYPE_AES128_CTS_HMAC_SHA256_128	0x0013
>> +#define ENCTYPE_AES256_CTS_HMAC_SHA384_192	0x0014
>> #define ENCTYPE_ARCFOUR_HMAC            0x0017
>> #define ENCTYPE_ARCFOUR_HMAC_EXP        0x0018
>> #define ENCTYPE_UNKNOWN         0x01ff
>> diff --git a/include/linux/sunrpc/gss_krb5_enctypes.h b/include/linux/su=
nrpc/gss_krb5_enctypes.h
>> index 87eea679d750..82aa74f1f2cf 100644
>> --- a/include/linux/sunrpc/gss_krb5_enctypes.h
>> +++ b/include/linux/sunrpc/gss_krb5_enctypes.h
>> @@ -15,11 +15,13 @@
>> /*
>>  * NB: This list includes DES3_CBC_SHA1, which was deprecated by RFC 842=
9.
>>  *
>> - * ENCTYPE_AES256_CTS_HMAC_SHA1_96
>> - * ENCTYPE_AES128_CTS_HMAC_SHA1_96
>> - * ENCTYPE_DES3_CBC_SHA1
>> + * ENCTYPE_AES128_CTS_HMAC_SHA256_192	20
>> + * ENCTYPE_AES128_CTS_HMAC_SHA256_128	19
>> + * ENCTYPE_AES256_CTS_HMAC_SHA1_96	18
>> + * ENCTYPE_AES128_CTS_HMAC_SHA1_96	17
>> + * ENCTYPE_DES3_CBC_SHA1		16
>>  */
>> -#define KRB5_SUPPORTED_ENCTYPES "18,17,16"
>> +#define KRB5_SUPPORTED_ENCTYPES "20,19,18,17,16"
>>=20
>> #else	/* CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES */
>>=20
>> @@ -27,12 +29,12 @@
>>  * NB: This list includes encryption types that were deprecated
>>  * by RFC 8429 and RFC 6649.
>>  *
>> - * ENCTYPE_AES256_CTS_HMAC_SHA1_96
>> - * ENCTYPE_AES128_CTS_HMAC_SHA1_96
>> - * ENCTYPE_DES3_CBC_SHA1
>> - * ENCTYPE_DES_CBC_MD5
>> - * ENCTYPE_DES_CBC_CRC
>> - * ENCTYPE_DES_CBC_MD4
>> + * ENCTYPE_AES256_CTS_HMAC_SHA1_96	18
>> + * ENCTYPE_AES128_CTS_HMAC_SHA1_96	17
>> + * ENCTYPE_DES3_CBC_SHA1		16
>> + * ENCTYPE_DES_CBC_MD5			3
>> + * ENCTYPE_DES_CBC_CRC			1
>> + * ENCTYPE_DES_CBC_MD4			2
>>  */
>> #define KRB5_SUPPORTED_ENCTYPES "18,17,16,3,1,2"
>>=20
>> diff --git a/net/sunrpc/auth_gss/gss_krb5_mech.c b/net/sunrpc/auth_gss/g=
ss_krb5_mech.c
>> index 1c092b05c2bb..2c5a11693e55 100644
>> --- a/net/sunrpc/auth_gss/gss_krb5_mech.c
>> +++ b/net/sunrpc/auth_gss/gss_krb5_mech.c
>> @@ -120,6 +120,54 @@ static const struct gss_krb5_enctype supported_gss_=
krb5_enctypes[] =3D {
>> 	  .cksumlength =3D 12,
>> 	  .keyed_cksum =3D 1,
>> 	},
>> +#ifdef CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES
>=20
>=20
> So you only want to define these if insecure enctypes are disabled?
> What's the rationale behind that?
>=20
> If these are newer and more secure then it seems like they should always
> be enabled regardless of whether the insecure ones are.

My initial concern in this area is interoperability. If "DISABLE" is
/not/ set, then clearly the distributor wants maximum interoperability
with legacy clients/servers/kdcs.

Any modern and secure distribution should set DISABLE_INSECURE_ENCTYPES,
and perhaps that should become the default.

I'm open to different approaches.


>> +	/*
>> +	 * AES-128 with SHA-2. See RFC 8009.
>> +	 */
>> +	{
>> +		.etype		=3D ENCTYPE_AES128_CTS_HMAC_SHA256_128,
>> +		.ctype		=3D CKSUMTYPE_HMAC_SHA256_128_AES128,
>> +		.name		=3D "aes128-cts-hmac-sha256-128",
>> +		.encrypt_name	=3D "cts(cbc(aes))",
>> +		.cksum_name	=3D "hmac(sha256)",
>> +		.encrypt	=3D krb5_encrypt,
>> +		.decrypt	=3D krb5_decrypt,
>> +		.mk_key		=3D gss_krb5_aes_make_key,
>> +		.encrypt_v2	=3D gss_krb5_aes_encrypt,
>> +		.decrypt_v2	=3D gss_krb5_aes_decrypt,
>> +		.signalg	=3D -1,
>> +		.sealalg	=3D -1,
>> +		.keybytes	=3D 16,
>> +		.keylength	=3D 16,
>> +		.blocksize	=3D 16,
>> +		.conflen	=3D 16,
>> +		.cksumlength	=3D 16,
>> +		.keyed_cksum	=3D 1,
>> +	}
>> +	/*
>> +	 * AES-256 with SHA-3. See RFC 8009.
>> +	 */
>> +	{
>> +		.etype		=3D ENCTYPE_AES256_CTS_HMAC_SHA384_192,
>> +		.ctype		=3D CKSUMTYPE_HMAC_SHA384_192_AES256,
>> +		.name		=3D "aes256-cts-hmac-sha384-192",
>> +		.encrypt_name	=3D "cts(cbc(aes))",
>> +		.cksum_name	=3D "hmac(sha384)",
>> +		.encrypt	=3D krb5_encrypt,
>> +		.decrypt	=3D krb5_decrypt,
>> +		.mk_key		=3D gss_krb5_aes_make_key,
>> +		.encrypt_v2	=3D gss_krb5_aes_encrypt,
>> +		.decrypt_v2	=3D gss_krb5_aes_decrypt,
>> +		.signalg	=3D -1,
>> +		.sealalg	=3D -1,
>> +		.keybytes	=3D 32,
>> +		.keylength	=3D 32,
>> +		.blocksize	=3D 16,
>> +		.conflen	=3D 16,
>> +		.cksumlength	=3D 24,
>> +		.keyed_cksum	=3D 1,
>> +	}
>> +#endif /* CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES */
>> };
>>=20
>> static const int num_supported_enctypes =3D
>> @@ -440,6 +488,8 @@ context_derive_keys_new(struct krb5_ctx *ctx, gfp_t =
gfp_mask)
>> 	switch (ctx->enctype) {
>> 	case ENCTYPE_AES128_CTS_HMAC_SHA1_96:
>> 	case ENCTYPE_AES256_CTS_HMAC_SHA1_96:
>> +	case ENCTYPE_AES128_CTS_HMAC_SHA256_128:
>> +	case ENCTYPE_AES256_CTS_HMAC_SHA384_192:
>> 		ctx->initiator_enc_aux =3D
>> 			context_v2_alloc_cipher(ctx, "cbc(aes)",
>> 						ctx->initiator_seal);
>> @@ -531,6 +581,8 @@ gss_import_v2_context(const void *p, const void *end=
, struct krb5_ctx *ctx,
>> 		return context_derive_keys_des3(ctx, gfp_mask);
>> 	case ENCTYPE_AES128_CTS_HMAC_SHA1_96:
>> 	case ENCTYPE_AES256_CTS_HMAC_SHA1_96:
>> +	case ENCTYPE_AES128_CTS_HMAC_SHA256_128:
>> +	case ENCTYPE_AES256_CTS_HMAC_SHA384_192:
>> 		return context_derive_keys_new(ctx, gfp_mask);
>> 	default:
>> 		return -EINVAL;
>> diff --git a/net/sunrpc/auth_gss/gss_krb5_seal.c b/net/sunrpc/auth_gss/g=
ss_krb5_seal.c
>> index 33061417ec97..252bc30e09aa 100644
>> --- a/net/sunrpc/auth_gss/gss_krb5_seal.c
>> +++ b/net/sunrpc/auth_gss/gss_krb5_seal.c
>> @@ -217,6 +217,8 @@ gss_get_mic_kerberos(struct gss_ctx *gss_ctx, struct=
 xdr_buf *text,
>> 		return gss_get_mic_v1(ctx, text, token);
>> 	case ENCTYPE_AES128_CTS_HMAC_SHA1_96:
>> 	case ENCTYPE_AES256_CTS_HMAC_SHA1_96:
>> +	case ENCTYPE_AES128_CTS_HMAC_SHA256_128:
>> +	case ENCTYPE_AES256_CTS_HMAC_SHA384_192:
>> 		return gss_get_mic_v2(ctx, text, token);
>> 	}
>> }
>> diff --git a/net/sunrpc/auth_gss/gss_krb5_unseal.c b/net/sunrpc/auth_gss=
/gss_krb5_unseal.c
>> index ba04e3ec970a..58d7b49a6a9a 100644
>> --- a/net/sunrpc/auth_gss/gss_krb5_unseal.c
>> +++ b/net/sunrpc/auth_gss/gss_krb5_unseal.c
>> @@ -221,6 +221,8 @@ gss_verify_mic_kerberos(struct gss_ctx *gss_ctx,
>> 		return gss_verify_mic_v1(ctx, message_buffer, read_token);
>> 	case ENCTYPE_AES128_CTS_HMAC_SHA1_96:
>> 	case ENCTYPE_AES256_CTS_HMAC_SHA1_96:
>> +	case ENCTYPE_AES128_CTS_HMAC_SHA256_128:
>> +	case ENCTYPE_AES256_CTS_HMAC_SHA384_192:
>> 		return gss_verify_mic_v2(ctx, message_buffer, read_token);
>> 	}
>> }
>> diff --git a/net/sunrpc/auth_gss/gss_krb5_wrap.c b/net/sunrpc/auth_gss/g=
ss_krb5_wrap.c
>> index 5f96e75f9eec..36659ab5bd58 100644
>> --- a/net/sunrpc/auth_gss/gss_krb5_wrap.c
>> +++ b/net/sunrpc/auth_gss/gss_krb5_wrap.c
>> @@ -571,6 +571,8 @@ gss_wrap_kerberos(struct gss_ctx *gctx, int offset,
>> 		return gss_wrap_kerberos_v1(kctx, offset, buf, pages);
>> 	case ENCTYPE_AES128_CTS_HMAC_SHA1_96:
>> 	case ENCTYPE_AES256_CTS_HMAC_SHA1_96:
>> +	case ENCTYPE_AES128_CTS_HMAC_SHA256_128:
>> +	case ENCTYPE_AES256_CTS_HMAC_SHA384_192:
>> 		return gss_wrap_kerberos_v2(kctx, offset, buf, pages);
>> 	}
>> }
>> @@ -590,6 +592,8 @@ gss_unwrap_kerberos(struct gss_ctx *gctx, int offset=
,
>> 					      &gctx->slack, &gctx->align);
>> 	case ENCTYPE_AES128_CTS_HMAC_SHA1_96:
>> 	case ENCTYPE_AES256_CTS_HMAC_SHA1_96:
>> +	case ENCTYPE_AES128_CTS_HMAC_SHA256_128:
>> +	case ENCTYPE_AES256_CTS_HMAC_SHA384_192:
>> 		return gss_unwrap_kerberos_v2(kctx, offset, len, buf,
>> 					      &gctx->slack, &gctx->align);
>> 	}
>>=20
>>=20
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>

--
Chuck Lever



