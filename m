Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25014735E00
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Jun 2023 21:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjFSTyV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Jun 2023 15:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjFSTyU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 19 Jun 2023 15:54:20 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA6011A
        for <linux-nfs@vger.kernel.org>; Mon, 19 Jun 2023 12:54:18 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35J9nGUY004111;
        Mon, 19 Jun 2023 19:54:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=IQck6HDj9Sy2enoFKFK7CagPDLCFDCoMhoLf54L9n+c=;
 b=Ngz3pZUTZFHgSQDUtnX3ZM4Oj2gbhVDJ1VyCsGixEv26FCPkU9OuCExKmS+1LdeY/oOi
 qN+xPa2GA7HQTN8DVN+XeUYb/O7y5EoddnEyzUdUGJA/QgCMA7Hw9PBUQBFxCG5DDs4c
 W6kdNJaZC/cKrO0JuMCeAL1OlxTpwnIqdIhbMdZ9qxsQwxb+aYHTamFBmZOE2ku528Vb
 hzHeg0hKOY2mzZBoAGa+2y8gAuL+0ThAFzDeOkw+EZf7KWWhmtd/XxvobCelURkjvTfu
 KWyk7Sda+9dgqRTR9eActkeRK849XIeS3PqauJO3j+qsYK/b5Y10PZVcyevs2Ty4zcm/ Kg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r94etk8gp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Jun 2023 19:54:15 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35JHNQ2i008459;
        Mon, 19 Jun 2023 19:54:14 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2045.outbound.protection.outlook.com [104.47.74.45])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r93941e7y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Jun 2023 19:54:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EIgp/JxpZQ4NQ02UBzxd8saMay5IKb6Onx/hk5gVVsY6ku/A+4rBcrRwK0sw5n6HK09I5q4WooWFJwFvCKOVYp5F8zIXPeUAfPk1yf6oCCZ2kIfI7EaRJezoGG0kJFYX2XeD8EEzawsyIWVxWE5y+2BndCK3JoShDBUB81olNzjYfIBOy0FASz+OLxwx3i17mAUoyijWVYV5bxck5dW35LJi6tmq/iYVgd5IY5+XM6/pnRJdPSmwLaI5EqWqFIBmhOI1lcL6fbxPYpo69iH+uy+b9PPTThFawYIxmD3qN90TqY/uQt0vJakCBBwd8vE3YgTvVhADqT8EiFc1Hnm3Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IQck6HDj9Sy2enoFKFK7CagPDLCFDCoMhoLf54L9n+c=;
 b=hpKfT5DmFcPOrfYsdUjx9zS+b8xy0s7TzwKJTS2pjbBb5py32yzYKJFiXuw4IPNOk9qJ7UEaQHLxEP8UIs0a7+ykbFrVuWU/vBZDGiQ/RFN4HIP+iU4Yy92fSiIzgURd17tDtihBIL0FwAUAJpN39PS5RiZ30PkFqUabhTRKEHfqklmvoNiUWea0wJNuZAvzpYLTGckBTz+Hh+dzATvg3QW2YL0tOkUrsSwnwuT6+U6IfCnRL+ekD4owzK9BEMo0FyEDeA1771Sa+7qSYG3iu6YnBo4LiOvreXrjfvyHGEfFDJfqRCFMQMgIC01Q75BATrKXOkjFZkUBgMSb+MMopQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQck6HDj9Sy2enoFKFK7CagPDLCFDCoMhoLf54L9n+c=;
 b=vcGfnLRKcKxDUNbAkE7QgismMso+CL7hI3SC9sJ6ZXumxF8/lqSXmKfjtEMYO3pOFBJEn3Im2sH3q512vkhUQcfTwjGkyo2apiM+9lBP1/Sca4Io1y5PHdBAkee82UZRTGCZP+0EaoGftbfYk5uJ69KZqEl7a8/yjErwg+zzAbI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB7169.namprd10.prod.outlook.com (2603:10b6:930:70::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Mon, 19 Jun
 2023 19:54:12 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3%4]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 19:54:06 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Dai Ngo <dai.ngo@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: NFSv4.0 Linux client fails to return delegation
Thread-Topic: NFSv4.0 Linux client fails to return delegation
Thread-Index: AQHZos/yj80TeHCL8EaHc5sJIN1lPa+SgHAAgAAJhAA=
Date:   Mon, 19 Jun 2023 19:54:06 +0000
Message-ID: <D1821C7B-7A7E-4B99-BAB2-89AF03223605@oracle.com>
References: <f9651599-846e-3331-9353-8a8264de1a27@oracle.com>
 <d5efe21b5f6a4bc7edd0f8ed441f63aa76b7e41a.camel@hammerspace.com>
In-Reply-To: <d5efe21b5f6a4bc7edd0f8ed441f63aa76b7e41a.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CY8PR10MB7169:EE_
x-ms-office365-filtering-correlation-id: e525e7f3-1790-4089-f65a-08db70fef0c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eak3hqHXLEXTqe6f1KyCU0RckhY3Y35KhyT8dP6EjxBJO/4/yoAnY+5KR4icqT3kUgY0P0nDM/eYaMFtK5JqqxgaZPy6Nq3o6ls5co/CpMBEdDMV3i5R/xxzRHxXJyox7v3w0QoJZ5n9e+ehaNs4laba5Tz02IkjbNEyItOwxHvLXZTGT45jvKvugXqrwICqgNf8k9LO3dIGsHoK97BE1cOW8Bhwebm+CUHcFmvtKGxqlnaCfq5q0eQ/fhPwv6IT79XUtl8WEprwnTOJH4sT1jXid98aEh5SNio+2TNd0QOxw1TFzyo43CKcB5EiGcrFdSEH0P54PU9iHEXtZYt9uZm2M3GnIRu5nA9VpZWLICMtzOeNdQH9EKYF+bieFzrLU438/XWaCrgdnjW1EWypHc09xJ4JScNW0Lg3D+cnkI+EWCGZDKwxAfcLhd0SKRNuGlfJLn1x7lV1hzFoI9bPlawTliF1onWEtFOKTxJdWhb3rOJDhXdvLsL3XHePKbHcCX/dGUMr2aJdge6V8yVbgHTy883/a9Nnei5Xx3/NVaxI70L9jqgHf3q3EsVG0INHb4ZwGjQ7/gU28VeVNPfD559SilkqgJ3cyzo4PivMHyphJFcIzjhKPXYZkHAi0mtfPKmaOTh1ZZduC+yRGfvpEw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(39860400002)(346002)(376002)(366004)(451199021)(91956017)(122000001)(2616005)(83380400001)(38070700005)(86362001)(2906002)(76116006)(5660300002)(4326008)(54906003)(186003)(66556008)(8676002)(66946007)(8936002)(64756008)(66446008)(66476007)(26005)(478600001)(38100700002)(41300700001)(36756003)(6916009)(6506007)(6512007)(53546011)(6486002)(71200400001)(316002)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/NF0p+P2sO49VxE2zjo/pjfFAzjh5pv5DfQh5JocgVJNFRmijfh2VmRuYKaq?=
 =?us-ascii?Q?6zISIguQ52IRv/YcFbfw3UOi8kUbi1CI77oWnIu1DMWNieB6vvi9Ev3QZeFN?=
 =?us-ascii?Q?a7DyjezL2ouVpOL64bjcC7eQc2lrIAGREZXnkz2B9vIXwtB1Fk8ty6qkhc0k?=
 =?us-ascii?Q?U5kxbPMENTGEOpRh6vFSEcnpB4z7Q7spxwpKIRm5ZhOHJ9qsyosblMLczRNJ?=
 =?us-ascii?Q?HHS8wMqgK9a+N8CrbINHGatiri6vFoz1rCmqLv/0wqvnooHyoJyEpTnPuzPq?=
 =?us-ascii?Q?MJPDmmYbap68vIsz3WYu6Mmakb4I642uSpzmO02/BWQ28DtU/0WUxg0PnjAi?=
 =?us-ascii?Q?bHlC4IO7UIsgGmn98grK+E2GIvzgdmg8qWNh5QGrbp+HppHaBkSAOZg+2GQW?=
 =?us-ascii?Q?DAVedtT3H9PJIRcajTBpcL6qthQt7A78CmHP6WP9qmQdbuZVZPJIF5nAz7SJ?=
 =?us-ascii?Q?CVdw1luGyAu+YPubKGfaOx2k6GmtoeH9+58Fnmlyfrrj7jDUdYwOShBfRA5s?=
 =?us-ascii?Q?TkBdJgkXacFsFGBK4aW0RtB38w7IRlUsK6FzfI/GyofGAb8OWiKgxJ67qZ43?=
 =?us-ascii?Q?obvOpwDuXgALDrSfO+kuIKcKXFwA5kQgjICiNh/r6BthNo9O7CYIORj6LXm+?=
 =?us-ascii?Q?PWaMGXGDmlT4MNUZugzHjcaeaxaenP9GA8VWjdlkHW5S2eSg41Fb3d/h8eTU?=
 =?us-ascii?Q?vEKMRE8VqwvztLq25Ad64J+mi+I94Rru6vyiJnN3sMEMTXwtfkYWFMhUjfCf?=
 =?us-ascii?Q?CN4Lp7mQsEwA6VB/Givf4437HJtpI2krSoDdzpDhvmEquA95hkoWVKbKbTUH?=
 =?us-ascii?Q?nZ4vUeu2YqoYkW5kpE5vSeojE/f8+/NDIyAFITlNG2918uSFeNgCaDPPpmRM?=
 =?us-ascii?Q?yf5+c7VcklnmMy2SW5ykVUcfFfN8f17Kf4D4NoToxXT6W+cFhD9VD0zx10xb?=
 =?us-ascii?Q?VrTkwMrPKKuXKYcBR+cJfBqThr5WIbjjpreQvRf6xcSyrzQ2xx6FCwRd214B?=
 =?us-ascii?Q?vdnV4ORnpEbcFJ3lAiJDwChKP+bG/sKfSofu/lOnGnQ22z9JZGPHgcBvohYb?=
 =?us-ascii?Q?pSP6JJayyc+05vj/qbV9EAvKNGbaesi04C0CmNKOoRhFJMf9RD/Dg431SZqp?=
 =?us-ascii?Q?hE8jlh8Ge0SK7nBwQMELhVehZrpCOMPjlqO7wCSl3UEjsC15l9oFMu5OO00B?=
 =?us-ascii?Q?s52RgRsIJ2ri8eMlmVaCZe5wBFmgLjNF5EKb1p0IsEPIljTwGXhO259plme0?=
 =?us-ascii?Q?Dd4MLgU9RtD82jG+E/I8XX7L6EdirwNUZS+arGIdOSWN87R0WlRkMjSCexka?=
 =?us-ascii?Q?YDbbFzu3cnGUCw692kcJyvu5psrD5dwWTJi7X0z4HfQOMLXfMi+YZjItm8YU?=
 =?us-ascii?Q?HAix8tlOrmgQRqkbI7Iq3r3heLPathMRuG57g63m/MWyX9Peb58LFgdVgP8f?=
 =?us-ascii?Q?BenFOQJd7Pf72FmJ/OWdwLPMQs0nfxcWS5JwASScIGLkAQCKUW84+1Sp4Q0r?=
 =?us-ascii?Q?/Cae2jLmL65bqdw7BiqPoq/H6nbDSHau5Lb2MP85Us+4TwEMTgqWOIGpagVQ?=
 =?us-ascii?Q?MEVRpzyQ1si2TQVwpD7z0iEWqhHT+MBvQ0hHZuV0kmLkck16zCgbgPLr6muZ?=
 =?us-ascii?Q?gA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <79BB46741B59F24AB2B3387C7B38CD7B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: S4zgGE3AISGWGTQ49N7BJjK3SxIhhQxQPa2KyzLZKD6FSf5CwoH5wvA3Qw264qVXr5rybttGSHn2W0SofBDCagTsuocZ2zhB1Vd0ILJXh3MJXIvx/jKen1Zkpp+HQ0cCJDdSzDiYOVTvrLcT64yGEWE3gLbNDgGlFfToHEK/7i1emYZdCTl44dk/MM0BWhxLBQOXS/B3zHF00taw+yJPfQ5CfRyVYQBx0tmSO158VQ5ZXsFE7xKQhnQ8oXfykDnqpXhp9b/EeVjtDteGN6nvgXKbeSs3QWmlNsDFQFHAk1cHyQLArbQSKUgO2s04+jMx6AW8s+sZSFpCD2Nla+0IZJ260dsiywbW6v00z0pPFePlyhZEG2WtGjNIumOZBML1+AQpRMZZiQHtZN6YcEcW1lvGvzzOTSEVNajwrXTAlalcV3kktQYnyMpb+jSDqa0yAg1KaQDtF2MagBL5TLnXOKSanWRZVcCM9siUlCOPs15smrsLn4QIY9oCCpEG971TNd+DL4jMiPGWIJQH5IZbEAeEio/3YnXpSyjvNIdzr5aHYW4IHfG0FZo3KZlrrHEBmYE2I/lbByUyDVhck9IjdAKfagX3IMONM57gstUBPsxYBavfyU3r5MQX9zYnUOVtsDQpke9NvDwRKPY+6H7r0y8khaknGJ8D9plEtmk8vl/1bo9E2aRFNDOQfU8MfK7H4uuQOzfr5I3AZNaYvKndM+W7yovZWPgE7uEJuwfpERInCDAblatGYXBkfQCRgV4huhJDHoRws0B6LHMkXTZQ6rlr/PJ/pDvdhWcq7wEZMhctVTbPIHuABenB53LUtKAj
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e525e7f3-1790-4089-f65a-08db70fef0c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2023 19:54:06.6402
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ipXEqZ8CKWUF1Fp/S6NmY6LD2NUWoNxBisJIAGdCY345iAcMESRa62PV8U7+y+3xGqlW6juQseJLOdxOquswxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7169
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-19_12,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306190184
X-Proofpoint-GUID: 56tpoDN84fdgfUEHXEeQTwy75_2w7X4Q
X-Proofpoint-ORIG-GUID: 56tpoDN84fdgfUEHXEeQTwy75_2w7X4Q
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 19, 2023, at 3:19 PM, Trond Myklebust <trondmy@hammerspace.com> wr=
ote:
>=20
> Hi Dai,
>=20
> On Mon, 2023-06-19 at 10:02 -0700, dai.ngo@oracle.com wrote:
>> Hi Trond,
>>=20
>> I'm testing the NFS server with write delegation support and the
>> Linux client
>> using NFSv4.0 and run into a situation that needs your advise.
>>=20
>> In this scenario, the NFS server grants the write delegation to the
>> client.
>> Later when the client returns delegation it sends the compound PUTFH,
>> GETATTR
>> and DELERETURN.
>>=20
>> When the NFS server services the GETATTR, it detects that there is a
>> write
>> delegation on this file but it can not detect that this GETATTR
>> request was
>> sent from the same client that owns the write delegation (due to the
>> nature
>> of NFSv4.0 compound). As the result, the server sends CB_RECALL to
>> recall
>> the delegation and replies NFS4ERR_DELAY to the GETATTR request.
>>=20
>> When the client receives the NFS4ERR_DELAY it retries with the same
>> compound
>> PUTFH, GETATTR, DELERETURN and server again replies the
>> NFS4ERR_DELAY. This
>> process repeats until the recall times out and the delegation is
>> revoked by
>> the server.
>>=20
>> I noticed that the current order of GETATTR and DELEGRETURN was done
>> by
>> commit e144cbcc251f. Then later on, commit 8ac2b42238f5 was added to
>> drop
>> the GETATTR if the request was rejected with EACCES.
>>=20
>> Do you have any advise on where, on server or client, this issue
>> should
>> be addressed?
>=20
> This wants to be addressed in the server. The client has a very good
> reason for wanting to retrieve the attributes before returning the
> delegation here: it needs to update the change attribute while it is
> still holding the delegation in order to ensure close-to-open cache
> consistency.
>=20
> Since you do have a stateid in the DELEGRETURN, it should be possible
> to determine that this is indeed the client that holds the delegation.

I think it needs to be made clear in a specification that this is
the intended and conventional server implementation needed for such
a COMPOUND.

RFC 7530 Section 14.2 says:

> The server will process the COMPOUND procedure by evaluating each of
> the operations within the COMPOUND procedure in order.

2nd paragraph of RFC 7530 Section 15.2.4 says:

>    The COMPOUND procedure is used to combine individual operations into
> a single RPC request. The server interprets each of the operations
> in turn. If an operation is executed by the server and the status of
> that operation is NFS4_OK, then the next operation in the COMPOUND
> procedure is executed. The server continues this process until there
> are no more operations to be executed or one of the operations has a
> status value other than NFS4_OK.

Obviously in this case the client has sent a well-formed COMPOUND,
but it's not one the server can execute given the ordering
constraint spelled out above.

Can you refer us to a part of any RFC that says it's appropriate
to look ahead at subsequent operations in an NFSv4.0 COMPOUND to
obtain a state or client ID? Otherwise the Linux client will have
the same problem with any server implementation that handles
GETATTR conflicts as described in RFC 7530 Section 16.7.5.

Based on this language I don't believe NFSv4.0 clients can rely on
server implementations to look ahead for client ID information. In
my view the client ought to provide a client ID by placing a RENEW
before the GETATTR. Even in that case, the server implementation
might not be aware that it needs to save the client ID from the
RENEW operation.


--
Chuck Lever


