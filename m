Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 848546F3230
	for <lists+linux-nfs@lfdr.de>; Mon,  1 May 2023 16:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbjEAOk5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 May 2023 10:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbjEAOk4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 1 May 2023 10:40:56 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6B098;
        Mon,  1 May 2023 07:40:54 -0700 (PDT)
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 341E2E1P013318;
        Mon, 1 May 2023 14:40:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=X/uuEhm+BB57eVpY4YjNiD4UqTV8jQT7yH+JcHEp6uY=;
 b=C4etyfvco4OwqIIvEzK8Ba9Lh8KJgek1QQFM3G5jzG1HfkX8BrCIzJxX6Bjhp6NFXThE
 6Butlb8/mZbxvusFEoUq02U5vxr9QBKEr+iZtg8DYLl40lDTE1cDl+02mV4RV4NWjk++
 OvwTdHD7yIuDqUdYedc01rAARJfPYykp/RtFUGHcKURPrUVU6SVRUhF99gMgXu3hMHnZ
 hVKvXDRr6ds8xTsS0zjrjawLli1/lZ+xZYWjsfRtDGQagbZLcbK6c8QdA0oxD9cs2bQ+
 RSHhmmAR5dgAQ3NQXx90vmv9yPiRBQOXZQYd6tjvsuHXkVJJoRgOWHpgc50/EUMeOn/V FA== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3qa502upbn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 May 2023 14:40:33 +0000
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 8095E13055;
        Mon,  1 May 2023 14:40:32 +0000 (UTC)
Received: from p1wg14924.americas.hpqcorp.net (10.119.18.113) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 1 May 2023 02:40:32 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Mon, 1 May 2023 02:40:32 -1200
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 1 May 2023 02:40:32 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LFuW6Ub5+P1pIJlkGfztWFNFE7g0/yvLqZIrUPUcEhk6glq7dr2469SdK8QpYfWDa+wXxI+rR6PoFi+9dC6J/sinkbPAvM1QnOZR0FjHIirc57BgIlbzfzHs1tdzqkLAWe3iaWxyx3P5erVEcj8eSYk4zItHJ9osLjpSiFtEY3VNPuZMIa9IzGMewI2fCJkMTZ5HMO0yxuu1p39Jh78WuK2Hrn1BJ05OcjxDufyoYToHrO8r4ntemNoPBBwcS1qeWF84Pa0yKvZy+FlH+p+CWwSUriJG1Cvq4mOfmE5OW6DNszWAGEEP2Zy64YtgZhkRhQIsmj9b1oR8+s2mUJWVBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/uuEhm+BB57eVpY4YjNiD4UqTV8jQT7yH+JcHEp6uY=;
 b=crn43tB3oyUG15ASMxIXeLB4t7+xejXa26em+TtRKt2meoH5deBf8LF3EYl0C5Kjh8OT/6Ams7/tY4scvmW+XMgVAdOunr7v/ZYzk3UKcUvi/7Z3GRcJEdz38M9VfRO+uQrBev/FojctKqpAJtAZnnC/CZfudVVN8kIzJvRR2qXaOUfCoFBJrbQo7ZPzFsx0iyHaBp8t3/uzQrDow0MuyLtn55rZ6whJWbFdAjVkRRoOCcU+JMRYSlNhACKyoKF9eM7TsRpAhPR9I/DteNqy2+LLINBR1chYqQj8IFUtWnKg7pGIfTqpsFxCWOo1y8SGbnnk0AEcEjFCCUdSgsxVWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c4::18)
 by SJ0PR84MB1507.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:431::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Mon, 1 May
 2023 14:40:30 +0000
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::71d7:118b:6b9:c794]) by MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::71d7:118b:6b9:c794%7]) with mapi id 15.20.6340.028; Mon, 1 May 2023
 14:40:30 +0000
From:   "Elliott, Robert (Servers)" <elliott@hpe.com>
To:     Ard Biesheuvel <ardb@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
CC:     "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "ebiggers@kernel.org" <ebiggers@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        "Chuck Lever" <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        "Scott Mayhew" <smayhew@redhat.com>
Subject: RE: [PATCH] SUNRPC: Avoid relying on crypto API to derive CBC-CTS
 output IV
Thread-Topic: [PATCH] SUNRPC: Avoid relying on crypto API to derive CBC-CTS
 output IV
Thread-Index: AQHZfDXyDhyXxYnAq0GHBuYVn79c7K9Fe2Gw
Date:   Mon, 1 May 2023 14:40:30 +0000
Message-ID: <MW5PR84MB18421BA9A3772DC313D06E5BAB6E9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
References: <20230501140408.2648535-1-ardb@kernel.org>
In-Reply-To: <20230501140408.2648535-1-ardb@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR84MB1842:EE_|SJ0PR84MB1507:EE_
x-ms-office365-filtering-correlation-id: 88a1ad33-f37f-46c9-77be-08db4a52033b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jJF6QnagANnSgTFn/TGj/UJxrLfAjVpslsuB0VR3/qWCS/yTiJGMkRExeSHvXAOi6HyLRoiEyvZfopbmzkJkeMxrI7nO0uFw99za88TEZQwtq649530OFrtAc0TgLsjpJ8vAQ8+Cl5RO2wg7wW0D7H/bWc4x4vuQFOcszzIXjD3cbxFDuqSA6HgliJQmcurHlgIJz1ru0UuBAuBVJu/s/NGIZdL6Ack6KEkcob8oPmqSoIVv3LLQ+CWD/+RahJBdxWYopivyEwFcnWuCT/FB1pYHWt9VRe408R0H+v6OOHM31C6ez5WkbA3gf9jRuMgZFrqyBxZ43aV1wzY3SosG40BNq3e4T/N/rJJXMhywk+CBc1FqlPojf1rOvvBsa3hAV0q+Rh/vnob+r6gwxEOc3YjMzpg74d9JoIVk1gth/E3UG2qeL09NFjvzGfcpjdA90/lQ026jVRBBV4xrafBmpnV9dtsACcMgGTZO2sfW/yAl1SKYCYsywRJ0roZLFHidSDKRut162SHPBSy3Ic9G9qGhogaEoXgzcGLuPRDfWYNetCS9RN1Bfrm698uMu3/IHeUAqB2SnT0RE49p5ONvE3IAQqtwXGms6uNlawTpAFCJoppYQlNmioRCRaRI1GHT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(376002)(346002)(396003)(366004)(451199021)(7416002)(41300700001)(5660300002)(52536014)(8676002)(8936002)(55016003)(86362001)(83380400001)(2906002)(110136005)(38070700005)(7696005)(54906003)(9686003)(6506007)(26005)(33656002)(122000001)(71200400001)(53546011)(82960400001)(478600001)(316002)(66946007)(64756008)(76116006)(66556008)(38100700002)(66476007)(4326008)(66446008)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fradGXoPyy7IE68ZzQmG7bbG6Y0BX0vEndfhGT8TX/aDmHjgr0uOcEiy7fHR?=
 =?us-ascii?Q?0TzhyNY8pqhomFPaWz+cOmLLZEcPBActnAbXbgSf78WVADEErDLlRqj/+mGc?=
 =?us-ascii?Q?y4lHmUxRHWalJUEXegechjt6PweCJgzuWmAN/XI0SQGVesgNM8lppbnp7JP1?=
 =?us-ascii?Q?7vhQ0I/8ikUlIPRU/KPPvdlcux/cVGlaHQvxldkIqeKsTtx67lK0rUvTuaLo?=
 =?us-ascii?Q?TTZP+Dxujo4BiwunoUvX9YKzPI6T9Yt9rPCGzubS2W5qm6C685TNrHfJEFux?=
 =?us-ascii?Q?js6t/YGyc/gHxJ/V8nyYwWUJsMDgEwOiW35yN+H+ckWIH9OaTIbQ0ZRTtPSt?=
 =?us-ascii?Q?7VsiWwaQm6jJslNyyCS9kNsJceaw6KAwH5BxvEN4Mwgmphh9aBO9K57T1VOH?=
 =?us-ascii?Q?asjchqZ+facFBXi9Y0w0DyRyhk7TxbgkC6rrPd1TdjbMEe8Ca83ROpnArstx?=
 =?us-ascii?Q?vLV+GfcJqfqRiUX+3NPDtCEBfQlv7WG6l6KVEEldwxltaTyTNxi8UvH/AoN5?=
 =?us-ascii?Q?RBJGAAePCdMMuPRegq7+8zbgFWaBCR+QkzLWwlAVOj/07zhorCftWyq268xs?=
 =?us-ascii?Q?X8zaAusbkhR5O3VXd+pTec5Y37lPrjo7PYCAI1hnw1a2hPl0FrHX8DJfJ/OA?=
 =?us-ascii?Q?tV1mKVVh/eBNyrJ5C5IvGmr5k/AwwFBt6t950oshexQh6JPDBnBySxrnIMhG?=
 =?us-ascii?Q?SzknkmARhO2Jy8nrWV/0hejxwk7x6CiWgWXiI2pJMomZgTAi11xssp+wiiwj?=
 =?us-ascii?Q?VxZmVSmCKaZE/vlRxmCG/r3eQHJHED8ilQBFpz8FSqkzu0WCiVwTssRZUmRe?=
 =?us-ascii?Q?ZW2QrQxqxQ4n6MaGJNH6yA2myFbdm0D765jWIyIguEqwt3n+ZLGQ4lOuYPvA?=
 =?us-ascii?Q?woTOjE5Hz66qyj20H22Yjt7N+jFeF2MfgfNbLd9t9fXL5Z/K/f8w3YDnwSgN?=
 =?us-ascii?Q?gRxim1epNNRgmr7TAqX4jykx2Nfl6xp4uGUJ3jPcnLhKDsC3InCqBMGnbjn1?=
 =?us-ascii?Q?zSrlR9rEhvQKHzWUISk4SPzKmtvpDo3SLL5dNHQ57BtY1jD6PPF1c61OB8oM?=
 =?us-ascii?Q?S6W1VTkKSPtg4JRmXNCBQ3U+N9OijANOUhdHH6KYgyXJs55Ak328OPodw1tN?=
 =?us-ascii?Q?lxzhCzjXb2YpG5eYo+JgYcgCxCt6jHQj07ses/WjR3G6+BN2XysL8a2p8/Tf?=
 =?us-ascii?Q?KCKfGgabpKD03F8M9j2I/tiZikc6u/fQNPUxdMwjc4KPKAuzwcu+seMzY46/?=
 =?us-ascii?Q?vA20lgViOnHBzJ+OnCIi1ZHbx83FdwCnwoT3ZnZFFllIZFxS8VPsVWaENoOO?=
 =?us-ascii?Q?RaFOM08LUozN2lkXiDotuvoEOM4XX4AnJlbXRJf27rFa/HG1KOtP05jNyfts?=
 =?us-ascii?Q?+92sHtDuZ1TKVQoz60SebtnoCOiOMSVqXhTKjnbswLJKehv5jmPRCFCPFk7e?=
 =?us-ascii?Q?DKG6rKcuWPOLnvc8+pSEH2JJXG9hGCDWmR25QpRekSKrB5e2pAeeGSeMoSRr?=
 =?us-ascii?Q?3ApSuh0VDgWaJCfQTKFxDjevlselsowvPkWQgkm04IMUINmMJtl+378kWVR0?=
 =?us-ascii?Q?kQEdeAkhm/2GtzgYSMI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 88a1ad33-f37f-46c9-77be-08db4a52033b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2023 14:40:30.4550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5WTF7nHHJSwZm7049Jj6T68z2o5MJEN19UcZqmA857aJGno807EZY+3OFuqBPUtN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR84MB1507
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: NB5NSP1mbPVVuLha6vRlTZnEOIkOdMBG
X-Proofpoint-ORIG-GUID: NB5NSP1mbPVVuLha6vRlTZnEOIkOdMBG
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-01_08,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 spamscore=0
 mlxlogscore=683 mlxscore=0 adultscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305010117
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> -----Original Message-----
> From: Ard Biesheuvel <ardb@kernel.org>
> Sent: Monday, May 1, 2023 9:04 AM
> Subject: [PATCH] SUNRPC: Avoid relying on crypto API to derive CBC-CTS ou=
tput
> IV
>=20
...
> +++ b/net/sunrpc/auth_gss/gss_krb5_crypto.c
> @@ -639,6 +639,13 @@ gss_krb5_cts_crypt(struct crypto_sync_skcipher *ciph=
er,
> struct xdr_buf *buf,
>=20
>  	ret =3D write_bytes_to_xdr_buf(buf, offset, data, len);
>=20
> +	/*
> +	 * CBC-CTS does not define an output IV but RFC 3962 defines it as the
> +	 * penultimate block of ciphertext, so copy that into the IV buffer
> +	 * before returning.
> +	 */
> +	if (encrypt)
> +		memcpy(iv, data, crypto_sync_skcipher_ivsize(cipher));
>  out:
>  	kfree(data);
>  	return ret;
> --
> 2.39.2

What about the decrypt (encrypt =3D=3D 0) case?

That function supports both encrypt and decrypt operations,
and both of its callers mention this IV expectation:

gss_krb5_aes_encrypt:
        /* Make sure IV carries forward from any CBC results. */
        err =3D gss_krb5_cts_crypt(cipher, buf,
                                 offset + GSS_KRB5_TOK_HDR_LEN + cbcbytes,
                                 desc.iv, pages, 1);
gss_krb5_aes_decrypt:
        /* Make sure IV carries forward from any CBC results. */
        ret =3D gss_krb5_cts_crypt(cipher, &subbuf, cbcbytes, desc.iv, NULL=
, 0);


