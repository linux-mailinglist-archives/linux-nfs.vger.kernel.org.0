Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6660D6DFC05
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Apr 2023 18:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjDLQ6j (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 Apr 2023 12:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjDLQ6i (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 12 Apr 2023 12:58:38 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542C446A3;
        Wed, 12 Apr 2023 09:58:17 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33CDfppc006455;
        Wed, 12 Apr 2023 16:57:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=mhEScA7kQnHueu79HCYpxkpbDlXXQswmT+59IzMTOkQ=;
 b=gc68AsXD2H9dkXMhqZUUGv9jy1WYDyH63LKquPHat/HK6ug/D1vTRCB3OXkK3cVL/AuZ
 N8EZULXr13RILudDsi0qkYLU61QDT1PZ/JiyIy+pElczYtBREwIKeObRD79L1VG5Fwui
 O2Rp2Gxw0wZ7LkKSwglDVK9GipvFxba9rO2ktybMQE3Edopym+bpVlkaB8VCcPikaM8F
 no1m068zE03GgCKNkaxAF6b7jZQXFysR68ACXx74pJGv36gOHxBYHT98sWKpLb4PghS3
 olDtZy+iDOpHka7GANcdwNnhK2BYnbzlrtmGz2Afm7W3Xed2k6RqKwDXEeKQwpNHCOw0 rQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pu0e7gqay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Apr 2023 16:57:32 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33CGCQoZ013182;
        Wed, 12 Apr 2023 16:57:31 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pwwgpkqxe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Apr 2023 16:57:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eVA7dZkpf1kVnEnKbn92wTEo20Y7iEXi6z2upyHnPVrH2JHH5uIkazn9CK0jMI92gznqHbAY1t6UhBVtq5RQeT8lavd+vDvlp/N6N2JFqMHiKZubcXSri8i1Y7FAAF7UU4ZKC+vKNpesApRRvF4NlJdeuQKNknFcQemOlovMCDsrHjKz0KUkhl+LT5YmnQL2Fkv8Ws7Pv7qsOxPTXx1lgQ3IMVII/J5YjW+uHmYLZkKvTZgdy6h/AiXxBbPECLC04IJksAUKomJWMc+6SUPBXPDyKjydo+U7IKPWpORrmhz3uWoXtElZVu5zONcBCSBegFMOX+/46W7Gctctp2YM+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mhEScA7kQnHueu79HCYpxkpbDlXXQswmT+59IzMTOkQ=;
 b=N4ZRk/JJBHP8QcK3pFqzM02mel0Pdyi5a7EPONcJUO8efgz7/fGEkaRhTEAtf1Y4oab7MkvfHAC0qY4dlDCYY8omFtawfIwQSNi4RuRw7Pl27jiip0+LLRoS1h+m9DrSY0B+e/vwYVZgg3u3Sq57HVNpeH+7tx21QwAT13krR1XdhQx5ud2Vz6Wr7HuGu3gbiw7yQXQKx8PV/pJpWKcfY/2ErjFs8OXpJos8GrUt0zGpdUIrXC6vM+SAu0zVHIxmbmPLpd/m20uFeP65n0e66FJ7YttPwOFLq7uKo9RlrTJPLHGEPBz9rgBqH/F2crIK1POf91Nw1Egin2FJB8aVAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mhEScA7kQnHueu79HCYpxkpbDlXXQswmT+59IzMTOkQ=;
 b=e2Ztovyq9EhxMcbkgbcavgT/M75KGwBkJ5r7AIF9vbjQA/LkanqCnp83Im7khYq7eej6FlqQLfBPTFdG0Ti8AkKafN7TozYBMSvKQ5Zj5TGU4kPaUBueXVCwdmUR4Y63f8HhdYLpwqcmkMNRNGWii5uRuPwKQ6LobMisO1s2tGQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB4669.namprd10.prod.outlook.com (2603:10b6:a03:2ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Wed, 12 Apr
 2023 16:57:29 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%7]) with mapi id 15.20.6298.030; Wed, 12 Apr 2023
 16:57:29 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     David Howells <dhowells@redhat.com>
CC:     Herbert Xu <herbert@gondor.apana.org.au>,
        Scott Mayhew <smayhew@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
Subject: Re: Did the in-kernel Camellia or CMAC crypto implementation break?
Thread-Topic: Did the in-kernel Camellia or CMAC crypto implementation break?
Thread-Index: AQHZbVdnKpgTbK+uIEG+SaoLQMk4e68n5P8A
Date:   Wed, 12 Apr 2023 16:57:29 +0000
Message-ID: <48886D84-1A04-4B07-A666-BB56684E759F@oracle.com>
References: <380323.1681314997@warthog.procyon.org.uk>
In-Reply-To: <380323.1681314997@warthog.procyon.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ0PR10MB4669:EE_
x-ms-office365-filtering-correlation-id: b7303d03-24fe-4bfa-dda7-08db3b770023
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EQXSWnR5Ws7RMIH0LXkYeCm9VE48a7zhuxNCXKZ4i7yoWCdS9Sf3gQKH+VzZGppm0lpmqtmTymunyQrRSxkDE8GB2AbT9AlrvbRheIDkobF8gvmPRgLy9Rbc1qZ7swTSH212KFIOgXfeXYZu/h7IOgFT0S/7DNBzcMvFFyfgM5qpU+poiKeMt1WqVKdQE7FWSbJlr+9CKizi46wWUZiCmoROYwbc2T33nB8yXUDoNYvROV8Fqn4LLrN7H3ScUN6h2sDgndnfSdlrvWEDOyvsc5FETX/83thK9kgGPSLa3Qe+xMvjeNFWh9ro4UwMLDu4Y3Gr+uuXPL05ni9gJ13quycfEq8CXm5WHfkCO7L2wYARa57oLYK0YVxOhqRu/SIMm+p6PY7IuIoZEknhS66hT2iwjMn4XWIe6SrYmN5ZRtR2WlrS8ma2y+K/VarWmAvmdYGSsv93XvNHdfqJ5Q+w97fMDWSWQh8HVq6y0t9dceNFQY3bRVD6h8CTltCLzdDmCYXqQ2N2U1cGYS49eBVu8U5zYU8V+ox/DULq2IwqMDn/m5cxGYujcPLHoS0xMKFKAziphwxK5hvU28wWeGeQA4Dfn6ULRVStOBftlhROj62VGYNJ892Zh0xOckgzrn4EicHVpbfm9DbzK58JPWzj6g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(136003)(346002)(366004)(376002)(451199021)(41300700001)(83380400001)(5660300002)(36756003)(8936002)(54906003)(71200400001)(316002)(478600001)(122000001)(6486002)(2616005)(91956017)(76116006)(66946007)(66556008)(186003)(66476007)(86362001)(66446008)(6916009)(4326008)(2906002)(64756008)(8676002)(38100700002)(26005)(38070700005)(53546011)(6512007)(6506007)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?O+RUVHfgtr36t5263vxPXThPKe2NqVUShENuJQZFc9VWR0XWlhNspkrC3zoU?=
 =?us-ascii?Q?QcZyPScolFaPptyXO93R/ipuLON0UDH4USabi/9SMIIUSbyeQ5mSsDfKJzg1?=
 =?us-ascii?Q?kdU7OCANGp3nAUdru3s6EJdN2pjE18V/Oai9coTVZ+6vKN7843DjTEWqmsvQ?=
 =?us-ascii?Q?IKLCqlXv6WQfqPs+IGe/35qYStDWFUNaB0YEiL3kK5XR1n206D5lVL2tOOpn?=
 =?us-ascii?Q?ea3zSKuCiBFjjtp25yXlB9+Wa2m6k/k0jb3rTFk35nBDSDWrewO1lQHYliIn?=
 =?us-ascii?Q?yoAX0kYiSq+tc+qx3lv6JRbDxks42mCpf50AX5rStuX42uYFQDzMoq7jK/Ti?=
 =?us-ascii?Q?ckNvGIog9g0dLtkyFPKo9MRdGXHqV6LNShPrqJ3kX+XzgloVCwwxvHjNBznL?=
 =?us-ascii?Q?5wodDtbx3paYgmpE0awrWZv5u1GaTnwC/qEZheENQzBRkJjOCSfg2mCYd/x0?=
 =?us-ascii?Q?ReoqKhoa/FBSaByTOPkloQ0y4OLWMZM/VRAvGC/3jW8quDAcQuhcnglW8IYj?=
 =?us-ascii?Q?89OgGY1oXz7Yax68fRXwXNT2dmQ1h7xYbJIH+/E0OC+2pgZCE6xEQuYUzpqI?=
 =?us-ascii?Q?uUZ9RkPkdqru9Mj5w7Yq7pxSzi9ST6wdr/kveOkBIzNHrmPwZvblkYG2Etsc?=
 =?us-ascii?Q?YUZZqR3oL/PTJ7O4nADVi0tSW9YPpempTgj5bV8AEUYn0BUj1q+zIGPS/40S?=
 =?us-ascii?Q?obU9I7JDlFFzvuoRTUiV2iQIvkUEhYHB65glfm0PuVrfN0JMzQOzoSsU1mxj?=
 =?us-ascii?Q?91gAvUumuf6f20orVLY/3nLlpZ7Y52r/ckCVEsszmUL/hErKFrNtqSFAgdWh?=
 =?us-ascii?Q?QYvlxSswqYw3ZB+9ToMwkPW/MWLnIEW40+Xu4rWZkvvN3VAC192tLWeiLfjs?=
 =?us-ascii?Q?aTKiZpT0de9F0yxdexR8mi3ncCc13s3PYo65sBuOAy+2DHZeU1hQq8090nDK?=
 =?us-ascii?Q?aKWsL4qTMVeBctFzUyvo+qzvLFL92S51QBFqBCvEw7QKdzHhXsxd+v2gZLLY?=
 =?us-ascii?Q?LGfzBxiIU7qMxvqemZkKQfG8F+FnL0TbdnmeApcuiDjEh/UfVGppATpEnePW?=
 =?us-ascii?Q?CK0y6GCkNd5eNeAskQmRSE1+ZnCtFbsP7ML+8nSR1XAjq8l7WKCkMX7S5NlJ?=
 =?us-ascii?Q?6iy9zYhZeV9KL+CijDWGvMPh7RoApv/BXyZvdLMGXX4N0zA1WTfE3tT2G30i?=
 =?us-ascii?Q?alSTen/b5rcnmQZELXavZMQQnY3qx3WXvMMrLJu8ZpcGvsDH+2LGOZBwvqm3?=
 =?us-ascii?Q?xbUp4fuPVMwCWf4t0hdEaJZ63qXltI4gjsm1nwkWDeKAkpQeqPo+6Pcf8a6p?=
 =?us-ascii?Q?3i1elQU5cg6P/m7cu7nKRfQ3VmQnY13APN49MUUkak6wwWZMxtFtwWRMcUST?=
 =?us-ascii?Q?mt7pVs/aY56MpbMPdVQY0VdxvdpCrX/cluaeOOlYf7XZ/0OqyyCMQ1S3Ni4v?=
 =?us-ascii?Q?uJnXR+08b8O++ykbNz7WIzOPxekpjNp9v1ZhNnLd6r67hOzth0JtJHucq5m5?=
 =?us-ascii?Q?AVinTG3pDLX7pxi2Y/3kvtK0bLNhv+hBq+cuW795L3u/4QmE3SOzGmGSydFF?=
 =?us-ascii?Q?50gje+l3ZFuvK7ljS0Y/HCrd+Hu1ofU8DCKtYsp4UeE2yDRFY6irML8M1mWn?=
 =?us-ascii?Q?GA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E13F21CEBF1AE44EBA12ABBFF8F72B0A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: q+5jYhex2RrkQuSAig/H486rC63e3VVWxcGd0YfW7Nr6oGQS7bCioDHoSiTmvyIy3qcKU84ejZKYpEl91dhxXAbVYFda+iDXbBYZ3KIQRmMjMEwFOlT8+udxnUr4inyPEz6ciK5Z1GWcOh8/hxfZw07TPw58Zx4fzLGXtyNRcYhENeO9JCvZZtaHAtZ4+6oXVdEgRJkIAtFaLlm4Ab01zuzhBDsbuzneJ6rYnl/VHYKsmLMzMnU+NQknFk3r6akpa9oiPDjaRGKgJhINJQU4ra6Xw7TUMdvhx36hJzZrCEJo/04SbpKA6FBBkSAymHwkvVtgFuwYedY5e0xeRsbc+Hl5QIJzTtvx9KR5Fk5sh1G9IncGG4wMRyVwWXkLbTGnrXdetMvj9tCcCXssDgXj0rRnGAHHewOkTYTss/GvVE7v3kQMywSTJvvBI11TW7YznfLcS9jQoXGjjfwnRaiimhHhh6TMe4g9wJTwPSgexJQ6dlAsJnY8LkZ0xCZapKDS1gPFwHIiGyj5fMDMksRyuUW1O84/1xU7/N8CoN+1a32rvjlBvPNcxfjlvTJvDc27gsHsQUfUBg1odMJpLMiy0/F1cMi86UAOVmg4yd905JGC/xAoQa9BrjOh9xDeZ6CH2SokTUCQ7siI7R+Q6K0E5E4sPKY6hEc/kGoB2vDiipItocd6eJusqFED+pB8ApwsD6rE7JSkWEHBOI2O0ZOnhUO3K1KlKZc1qSYnHfqPIU8jRI3Q0UjMXHAwWt1bm2emxWjm2Vv6AMYvM3yCfDsHJzGaxNdZ24e5Kike4PCiw71j2UEsgi4ZEmU/JMrWKKpXjUX+o0miywXSKqhsW5fjT0IIMXylgZtLMZsVWrjCj+B5qCIoNIpSYzq7mnuDX93Q
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7303d03-24fe-4bfa-dda7-08db3b770023
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2023 16:57:29.2209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wwh/4r2FhQTCfkx+kGFfj5IGUxezXd8VQ3pVrEu4ZN5jwJc+fC/kpnWtYhv6/9XkideRLwCzzdVATipOzDhe2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4669
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-12_08,2023-04-12_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 adultscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304120147
X-Proofpoint-ORIG-GUID: nFPtJjMVyBnS4NSMiT4wmspn7Q4wX7sL
X-Proofpoint-GUID: nFPtJjMVyBnS4NSMiT4wmspn7Q4wX7sL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Apr 12, 2023, at 11:56 AM, David Howells <dhowells@redhat.com> wrote:
>=20
> Hi Chuck, Herbert,
>=20
> I was trying to bring my krb5 crypto lib patches up to date, but noticed =
that
> the Camellia encryption selftests are failing (the key derivation tests w=
ork,
> but the crypto tests failed).
>=20
> After some investigation that didn't get anywhere, I tried the sunrpc kun=
it
> tests that Chuck added - and those fail similarly (dmesg attached below).=
  I
> tried the hardware accelerated version also and that has the same failure=
.

Ah, I see Scott is Cc'd. Yes, Scott reported this to me yesterday.


> Note that Chuck and I implemented the kerberos Camellia routines
> independently.

Yes, but we implemented the same unit tests (from RFC 6803).


> David
> ---
>    KTAP version 1
>    # Subtest: RFC 6803 suite
>    1..3
>        KTAP version 1
>        # Subtest: RFC 6803 key derivation
>        ok 1 Derive Kc subkey for camellia128-cts-cmac
>        ok 2 Derive Ke subkey for camellia128-cts-cmac
>        ok 3 Derive Ki subkey for camellia128-cts-cmac
>        ok 4 Derive Kc subkey for camellia256-cts-cmac
>        ok 5 Derive Ke subkey for camellia256-cts-cmac
>        ok 6 Derive Ki subkey for camellia256-cts-cmac
>    # RFC 6803 key derivation: pass:6 fail:0 skip:0 total:6
>    ok 1 RFC 6803 key derivation
>        KTAP version 1
>        # Subtest: RFC 6803 checksum
>        ok 1 camellia128-cts-cmac checksum test 1
>        ok 2 camellia128-cts-cmac checksum test 2
>        ok 3 camellia256-cts-cmac checksum test 3
>        ok 4 camellia256-cts-cmac checksum test 4
>    # RFC 6803 checksum: pass:4 fail:0 skip:0 total:4
>    ok 2 RFC 6803 checksum
>        KTAP version 1
>        # Subtest: RFC 6803 encryption
>    # RFC 6803 encryption: EXPECTATION FAILED at net/sunrpc/auth_gss/gss_k=
rb5_test.c:1389
>    Expected memcmp(param->expected_result->data, buf.head[0].iov_base, bu=
f.len) =3D=3D 0, but
>        memcmp(param->expected_result->data, buf.head[0].iov_base, buf.len=
) =3D=3D 135 (0x87)
>=20
> encrypted result mismatch
>    # RFC 6803 encryption: EXPECTATION FAILED at net/sunrpc/auth_gss/gss_k=
rb5_test.c:1393
>    Expected memcmp(param->expected_result->data + (param->expected_result=
->len - checksum.len), checksum.data, checksum.len) =3D=3D 0, but
>        memcmp(param->expected_result->data + (param->expected_result->len=
 - checksum.len), checksum.data, checksum.len) =3D=3D -108 (0xfffffffffffff=
f94)
>=20
> HMAC mismatch
>        not ok 1 Encrypt empty plaintext with camellia128-cts-cmac
>    # RFC 6803 encryption: EXPECTATION FAILED at net/sunrpc/auth_gss/gss_k=
rb5_test.c:1389
>    Expected memcmp(param->expected_result->data, buf.head[0].iov_base, bu=
f.len) =3D=3D 0, but
>        memcmp(param->expected_result->data, buf.head[0].iov_base, buf.len=
) =3D=3D -49 (0xffffffffffffffcf)
>=20
> encrypted result mismatch
>    # RFC 6803 encryption: EXPECTATION FAILED at net/sunrpc/auth_gss/gss_k=
rb5_test.c:1393
>    Expected memcmp(param->expected_result->data + (param->expected_result=
->len - checksum.len), checksum.data, checksum.len) =3D=3D 0, but
>        memcmp(param->expected_result->data + (param->expected_result->len=
 - checksum.len), checksum.data, checksum.len) =3D=3D -3 (0xfffffffffffffff=
d)
>=20
> HMAC mismatch
>        not ok 2 Encrypt 1 byte with camellia128-cts-cmac
>    # RFC 6803 encryption: EXPECTATION FAILED at net/sunrpc/auth_gss/gss_k=
rb5_test.c:1389
>    Expected memcmp(param->expected_result->data, buf.head[0].iov_base, bu=
f.len) =3D=3D 0, but
>        memcmp(param->expected_result->data, buf.head[0].iov_base, buf.len=
) =3D=3D -36 (0xffffffffffffffdc)
>=20
> encrypted result mismatch
>    # RFC 6803 encryption: EXPECTATION FAILED at net/sunrpc/auth_gss/gss_k=
rb5_test.c:1393
>    Expected memcmp(param->expected_result->data + (param->expected_result=
->len - checksum.len), checksum.data, checksum.len) =3D=3D 0, but
>        memcmp(param->expected_result->data + (param->expected_result->len=
 - checksum.len), checksum.data, checksum.len) =3D=3D 44 (0x2c)
>=20
> HMAC mismatch
>        not ok 3 Encrypt 9 bytes with camellia128-cts-cmac
>    # RFC 6803 encryption: EXPECTATION FAILED at net/sunrpc/auth_gss/gss_k=
rb5_test.c:1389
>    Expected memcmp(param->expected_result->data, buf.head[0].iov_base, bu=
f.len) =3D=3D 0, but
>        memcmp(param->expected_result->data, buf.head[0].iov_base, buf.len=
) =3D=3D -58 (0xffffffffffffffc6)
>=20
> encrypted result mismatch
>    # RFC 6803 encryption: EXPECTATION FAILED at net/sunrpc/auth_gss/gss_k=
rb5_test.c:1393
>    Expected memcmp(param->expected_result->data + (param->expected_result=
->len - checksum.len), checksum.data, checksum.len) =3D=3D 0, but
>        memcmp(param->expected_result->data + (param->expected_result->len=
 - checksum.len), checksum.data, checksum.len) =3D=3D -103 (0xfffffffffffff=
f99)
>=20
> HMAC mismatch
>        not ok 4 Encrypt 13 bytes with camellia128-cts-cmac
>    # RFC 6803 encryption: EXPECTATION FAILED at net/sunrpc/auth_gss/gss_k=
rb5_test.c:1389
>    Expected memcmp(param->expected_result->data, buf.head[0].iov_base, bu=
f.len) =3D=3D 0, but
>        memcmp(param->expected_result->data, buf.head[0].iov_base, buf.len=
) =3D=3D 160 (0xa0)
>=20
> encrypted result mismatch
>    # RFC 6803 encryption: EXPECTATION FAILED at net/sunrpc/auth_gss/gss_k=
rb5_test.c:1393
>    Expected memcmp(param->expected_result->data + (param->expected_result=
->len - checksum.len), checksum.data, checksum.len) =3D=3D 0, but
>        memcmp(param->expected_result->data + (param->expected_result->len=
 - checksum.len), checksum.data, checksum.len) =3D=3D 95 (0x5f)
>=20
> HMAC mismatch
>        not ok 5 Encrypt 30 bytes with camellia128-cts-cmac
>    # RFC 6803 encryption: EXPECTATION FAILED at net/sunrpc/auth_gss/gss_k=
rb5_test.c:1389
>    Expected memcmp(param->expected_result->data, buf.head[0].iov_base, bu=
f.len) =3D=3D 0, but
>        memcmp(param->expected_result->data, buf.head[0].iov_base, buf.len=
) =3D=3D -150 (0xffffffffffffff6a)
>=20
> encrypted result mismatch
>    # RFC 6803 encryption: EXPECTATION FAILED at net/sunrpc/auth_gss/gss_k=
rb5_test.c:1393
>    Expected memcmp(param->expected_result->data + (param->expected_result=
->len - checksum.len), checksum.data, checksum.len) =3D=3D 0, but
>        memcmp(param->expected_result->data + (param->expected_result->len=
 - checksum.len), checksum.data, checksum.len) =3D=3D 48 (0x30)
>=20
> HMAC mismatch
>        not ok 6 Encrypt empty plaintext with camellia256-cts-cmac
>    # RFC 6803 encryption: EXPECTATION FAILED at net/sunrpc/auth_gss/gss_k=
rb5_test.c:1389
>    Expected memcmp(param->expected_result->data, buf.head[0].iov_base, bu=
f.len) =3D=3D 0, but
>        memcmp(param->expected_result->data, buf.head[0].iov_base, buf.len=
) =3D=3D 24 (0x18)
>=20
> encrypted result mismatch
>    # RFC 6803 encryption: EXPECTATION FAILED at net/sunrpc/auth_gss/gss_k=
rb5_test.c:1393
>    Expected memcmp(param->expected_result->data + (param->expected_result=
->len - checksum.len), checksum.data, checksum.len) =3D=3D 0, but
>        memcmp(param->expected_result->data + (param->expected_result->len=
 - checksum.len), checksum.data, checksum.len) =3D=3D 22 (0x16)
>=20
> HMAC mismatch
>        not ok 7 Encrypt 1 byte with camellia256-cts-cmac
>    # RFC 6803 encryption: EXPECTATION FAILED at net/sunrpc/auth_gss/gss_k=
rb5_test.c:1389
>    Expected memcmp(param->expected_result->data, buf.head[0].iov_base, bu=
f.len) =3D=3D 0, but
>        memcmp(param->expected_result->data, buf.head[0].iov_base, buf.len=
) =3D=3D 108 (0x6c)
>=20
> encrypted result mismatch
>    # RFC 6803 encryption: EXPECTATION FAILED at net/sunrpc/auth_gss/gss_k=
rb5_test.c:1393
>    Expected memcmp(param->expected_result->data + (param->expected_result=
->len - checksum.len), checksum.data, checksum.len) =3D=3D 0, but
>        memcmp(param->expected_result->data + (param->expected_result->len=
 - checksum.len), checksum.data, checksum.len) =3D=3D -106 (0xfffffffffffff=
f96)
>=20
> HMAC mismatch
>        not ok 8 Encrypt 9 bytes with camellia256-cts-cmac
>    # RFC 6803 encryption: EXPECTATION FAILED at net/sunrpc/auth_gss/gss_k=
rb5_test.c:1389
>    Expected memcmp(param->expected_result->data, buf.head[0].iov_base, bu=
f.len) =3D=3D 0, but
>        memcmp(param->expected_result->data, buf.head[0].iov_base, buf.len=
) =3D=3D 64 (0x40)
>=20
> encrypted result mismatch
>    # RFC 6803 encryption: EXPECTATION FAILED at net/sunrpc/auth_gss/gss_k=
rb5_test.c:1393
>    Expected memcmp(param->expected_result->data + (param->expected_result=
->len - checksum.len), checksum.data, checksum.len) =3D=3D 0, but
>        memcmp(param->expected_result->data + (param->expected_result->len=
 - checksum.len), checksum.data, checksum.len) =3D=3D -196 (0xfffffffffffff=
f3c)
>=20
> HMAC mismatch
>        not ok 9 Encrypt 13 bytes with camellia256-cts-cmac
>    # RFC 6803 encryption: EXPECTATION FAILED at net/sunrpc/auth_gss/gss_k=
rb5_test.c:1389
>    Expected memcmp(param->expected_result->data, buf.head[0].iov_base, bu=
f.len) =3D=3D 0, but
>        memcmp(param->expected_result->data, buf.head[0].iov_base, buf.len=
) =3D=3D -238 (0xffffffffffffff12)
>=20
> encrypted result mismatch
>    # RFC 6803 encryption: EXPECTATION FAILED at net/sunrpc/auth_gss/gss_k=
rb5_test.c:1393
>    Expected memcmp(param->expected_result->data + (param->expected_result=
->len - checksum.len), checksum.data, checksum.len) =3D=3D 0, but
>        memcmp(param->expected_result->data + (param->expected_result->len=
 - checksum.len), checksum.data, checksum.len) =3D=3D 168 (0xa8)
>=20
> HMAC mismatch
>        not ok 10 Encrypt 30 bytes with camellia256-cts-cmac
>    # RFC 6803 encryption: pass:0 fail:10 skip:0 total:10
>    not ok 3 RFC 6803 encryption
> # RFC 6803 suite: pass:2 fail:1 skip:0 total:3
> # Totals: pass:10 fail:10 skip:0 total:20
> not ok 3 RFC 6803 suite
>=20

--
Chuck Lever


