Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32187735F42
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Jun 2023 23:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjFSVcL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Jun 2023 17:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjFSVcK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 19 Jun 2023 17:32:10 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005719C
        for <linux-nfs@vger.kernel.org>; Mon, 19 Jun 2023 14:32:08 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35J9n2BD004084;
        Mon, 19 Jun 2023 21:32:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=vBB4n5dhhBOmYdOoxPohJIhnLkU8suv+fJMyee1VWAM=;
 b=0+NmoFH5SEhHxi3z8A0HSpr52SysYp5HrjdV0Eg5pThuiAm7tt6oBHXnZb61SxUqmX14
 XWb47f+MXLlxWKOkCMIDXCJVHY5HNaiqin+CxHSSzWnJ7xPeyv3my1KqDvsfhDYUR6kL
 iZD7fLpTqMw16ONwDILGNrW2Ff8eO1QTa9Ntlcsx9O4ID7VpYMhBAt4q1GDZWZTjw9El
 uoE3n5gJ9ynuxjJNbar9ZfU1Afj24piEtbQIZ1K9koNFEU0hpo6ZcCqkz/KB9rjTUqBd
 Ez23ccoLyIfqIuiJ9VQbiVuY9/hVGFOGJehmCRy/nGosMkf+E9aj+94/2vlXvkdMPoJ0 nw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r94vckc3k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Jun 2023 21:32:06 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35JLPujb032835;
        Mon, 19 Jun 2023 21:32:05 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r9394t8as-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Jun 2023 21:32:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UT3j0oK3xRIddOOVVQjp5Z6qzeygTWJLsZYCwtpRhmyqnyrHxvt4mQmUtF0FyMrsJMxa9q3RupoZcKOl+eemaeAK9JTAxNshaEuRHiQ2CPk7yoiqHDvLVXCMKlilGk2nuJZ7ocShNf7cSkyLUoLrGO7fxwhPVSa86kAD6eWihpnBudm4Og87uMNYrDTaHbQ6Hr0s6gUvJv/vR67/OeZ/RilGBi3WWJRyb4F1rMvCT3X4qAk71or6lySd+PETKhoQUqP30G3ZRi4kwgE6428DLo2KH9lQOHEEi16Wy03naGBD4FZnbaJT53knfS9PyYyKGtHzOKQV612NI2OGS8gPZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vBB4n5dhhBOmYdOoxPohJIhnLkU8suv+fJMyee1VWAM=;
 b=YqW0pjrGTTqg+7MK1Bd0mAiodMOaGb9P54GYtD2aUlquD2+HQrxMiz1VRDJtVcgasHOdm4keK5OTPucRTDVwQ3GiG592HSp14btIEImo45dn+qJCk4vdtvpfm8ZcVUx2Wg95ujTPG8siZJpNf7RyvvXVW+mrEIqZqJfbnYz9cgY+kWsBjpWCIJ/QNvYKsvVgspP95WQS3XJcCo3tyLyjJevagBX/yrzyfXyIb69Kl7LQpHwoHktXlp76l/xji0Bxbtbvh1/gfktrvKQKhOGhcDFkCMPk30lCbYZtqNqhdUKSk15cyrSNNKuBMtuYR8YZSxUbFcUz2T0/iJGSl4J91A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vBB4n5dhhBOmYdOoxPohJIhnLkU8suv+fJMyee1VWAM=;
 b=a+NTI+H/KV2hKcdkcA2fkX3YCz8yCclqJB/p9JC4nc1elqgGf4tjmDRGjSdhCCcjueLUYMHPnlj0Uh8JP3L8dYcZaDA3adGzCoRhZWRpp+92Vy/pD13XhnxuVArrDbaiSEOZgnqNgl2zCZ3dUb17zwI7RW+MX8Wi0ofzhT1uWWs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB5549.namprd10.prod.outlook.com (2603:10b6:a03:3d8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.42; Mon, 19 Jun
 2023 21:31:59 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3%4]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 21:31:58 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Dai Ngo <dai.ngo@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: NFSv4.0 Linux client fails to return delegation
Thread-Topic: NFSv4.0 Linux client fails to return delegation
Thread-Index: AQHZos/yj80TeHCL8EaHc5sJIN1lPa+SgHAAgAAJhACAAAceAIAAFDMA
Date:   Mon, 19 Jun 2023 21:31:58 +0000
Message-ID: <EA4CCD37-4F39-470E-BF07-BE6C1E609C24@oracle.com>
References: <f9651599-846e-3331-9353-8a8264de1a27@oracle.com>
 <d5efe21b5f6a4bc7edd0f8ed441f63aa76b7e41a.camel@hammerspace.com>
 <D1821C7B-7A7E-4B99-BAB2-89AF03223605@oracle.com>
 <8d6521a18dd88d6fcf5e7cc05d9a5936ff56db94.camel@hammerspace.com>
In-Reply-To: <8d6521a18dd88d6fcf5e7cc05d9a5936ff56db94.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ0PR10MB5549:EE_
x-ms-office365-filtering-correlation-id: aa370018-a840-47f1-4691-08db710c9cde
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5SI91Iyzny7veE8snjs5Ch3NEq+6hiR4V0lOndcKEiBuUM5xUySyh8/fQOj/nRlo5Nc+EVXb9WlzFpAE/2W0z4NMTftI4u/swDIlCgUfKWIGVhxdg7JWjscKEns2rjh7J8DjCsLmxTD9SG98Io4oc4z2tFCHxzeR3370bNbDo85DaXNI4iIELO+Kclip3Uq14h8jUnZE3P++sohdvCh+B8RJCXENeh/XIQuHhuegQTeNWbLihmUOD0uE8cQ9bDB/nS1ivV7mF/Lsz/4VJVh28bdEnX5veUC/PbGIk96GaLe9MsfQ13e0orKICIEcgTS6IKMoT0swtV91L+sA4UqwS77db85Dy9E6yEyFtSkmBdoURsXVuVQsiqsZN/KXnAnW1TeO81tpvDamJ/ZC2fyX5ljyekXP6EMxjvgmME3I5IH5yUSHqzlqxKo7EgR5MJMAh7bmg0dsEJQlrG/NTjP86CI8Vp3BZ31XXNOahYudKoXnS9+K15KmUCsjOu57BcpgXwQSbn6qZBSF66wn3HtpM44BmU/pEes3isajNPbio82uAOQKwadeZ5yfP29jFsCSkSZP6GJmrL3p3XTPKC64cOymcQo9RJlrjoWHw7CE1HSaS3KrwdhfHMCyJMh33z29BESCzrgW6OIHyjaq7sLmoQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(376002)(346002)(39860400002)(136003)(451199021)(66476007)(86362001)(66899021)(66946007)(6916009)(4326008)(66556008)(91956017)(76116006)(66446008)(64756008)(38100700002)(41300700001)(122000001)(316002)(2906002)(5660300002)(8936002)(8676002)(38070700005)(186003)(36756003)(6506007)(6512007)(26005)(53546011)(33656002)(83380400001)(2616005)(54906003)(6486002)(478600001)(71200400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MVUTj8yi9JLOsWQnEWhPsYolsN3btvrZ8DcV+lBJssSR85odd7FOJY3i6ruD?=
 =?us-ascii?Q?tFyhXLyq/znvruZhvjpEwbw7SRf81z1IZT3+QUeDap70h+xBYKHIXWjVxM8E?=
 =?us-ascii?Q?1++pgz04IQyrKrXeTT+5U0EVIeOt7GFeZqe2zN7x4UkyxC0WaafNiyDBUTjV?=
 =?us-ascii?Q?4yj/eqpSXcV7L2biSXesI95BetSztIpKwx6CAUeCEWIUCOi0hmBcoTYbDZUj?=
 =?us-ascii?Q?KE8RM4nfNGrFHwvwHEKURWZLa0Wf5m+qXujJrH5VkI3z4u6smKNcML+bKhde?=
 =?us-ascii?Q?tVx8/W7DyKpbQA+N8Itqwyu1I+0W47TQg0/pbbM3klrN4PNr/S5PU3O85qrD?=
 =?us-ascii?Q?98I154eOxlq3djdz2oNXzqTWXLvdMgYZZCNRFM1DF2ijux5GQ5uDZw/ISbfC?=
 =?us-ascii?Q?9eYNeZnbFuyVHcmtJPb+cTALyMfFTFqIzULC0ilosJNw1DbVN86ZeFueRHU3?=
 =?us-ascii?Q?b0UBzsor+JM6DFN/NkFpdRo3f/jS7nMdZo1VKDwMnt2ngEPLgTJrSJnEoSCk?=
 =?us-ascii?Q?R5HvdY9o7wmFiJQSs1gUiJX5xCmGTf4nx10hkjkQgIWLsZ1gat1JtXtftY5k?=
 =?us-ascii?Q?3FlixDvEq66VWdFUorL3aneWcqzSnHrqhkRnvdkpclIdzr8/8A/hvzjc1ZVW?=
 =?us-ascii?Q?T/dRrTFFlBnS35VRHy2Pq/cA6JNqQWmj40M4f6yxWFby7Bvl5M5Izx/I/tkV?=
 =?us-ascii?Q?Ec7++MRAKTHp5QxD3x65c0qXY8H48ElaHgfHPLM0GB8yxC7CW7WmI2lx/BqF?=
 =?us-ascii?Q?1iP9kXZ4Oz+dDOXIbDW++3FWo6VZWbhIcuJl+S6Iaim6VP2i5tvkFPpZ4Uxh?=
 =?us-ascii?Q?v6tidqH8927/nTe2g/tlKmjgREQK20YywXrAEC/qZJXBMNCHSyJvr23tcAR4?=
 =?us-ascii?Q?zG6CE66833QF5ykFtLjEifzz3SC7qqrApEmkRxxHO7LAog3UyvGBd0KYs6D0?=
 =?us-ascii?Q?L5/A5NDQP7OKs6Orh+EvRFaxSx1N4fvdImCDR6M1PmUCsaCcwX0X+N7lhL1p?=
 =?us-ascii?Q?kg/MC2u4bnyu5j6cZE0uOLr2NULOIwtRIcafjVvE3Fg2MM4ozLx/stiXSqHL?=
 =?us-ascii?Q?X21xxspqsCpN49z2y3c1B1G1Vm6qCha7e0NgPG4QjPAMW2VYLlqJ8dBAVKC8?=
 =?us-ascii?Q?A8qPwVntIlDOrn94rQseFlCiv/2DVBpW3PY1ZIXcJR0fveYSjebXvmnaShxC?=
 =?us-ascii?Q?DiTwL+rFcGviOgB29ii5786Fx3U25YJD5F5G9II5pxT/SGCiZ6fAHLrphwt2?=
 =?us-ascii?Q?oWbYGcJFH7ybHk2TqoLQnH+xHWexm69bWS3Y3S9WsNuDv/2XeUkeQokGBy8H?=
 =?us-ascii?Q?amgrnn7afMBH22YnlaHq2f7ss+tWDnglNoW4zesBCtLFnT69zWznlcJJ5gxY?=
 =?us-ascii?Q?JqwVo/McxFXUjCxuWTmMAX344aPDDDPt3aVhiUbETUgbaPfaJBby4IY+dHLk?=
 =?us-ascii?Q?mT0ofVu7iS/CKlkGZFpzlDkHxp2/fUnlS2dVGXvIYETKwJ1osrqLT846552C?=
 =?us-ascii?Q?aQ2KB9h6elSsDIRFGQbQAHVqt+yQpoR4r5MY73bR4+zMXh8Nh0koo4Phu6SS?=
 =?us-ascii?Q?OPCigjnxH7AtVJce3d63GjS+d9TPS8RS65n9y3GCipWjwVYWUx9D5sq3SW1t?=
 =?us-ascii?Q?ew=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B643DD36EC7D54459CF785C44773AF43@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3nlBi2lRz0VwpZbdHgluSzg9WyCoH5f/EbdbuyJyDqHdrggUciOEpEpm498TemApbP300pi1mZAqOZlDLjaoB+vbEPHz1hifBPCBAsOy0rtFrUynWD1PyZI3WwU1iygMOL1oeiyFLG4LgwiJmKrQhOa9LNsn8mDh8gu9GX2oO9zURRncVgz6hymV5Wgsg80wwF47K6+UR3cjOSZn0lxuVK7sn5qa84g/eyh3Sn8o72aI1sExpQq5tIfJ/Q1Zz9/X3qKx4cBPykalcYa7QXXYdA1Owsa+EJMK5nRndOXxDS587bg/a3GMcfWeYAGz3ZNl1sMyd4Ou6dy0Qn8eDP+zNDU5x+No1i7OE4l48lS9zdMZuP2/v+c/6wdEfy9Y++1gZNhZ4dh3jQechiCZliL01SYtr16WmOgc/Vez3iXjoYY9aoJB8ecSoKFfTMnXusGXkFGh3i6K68MKSIjkZBQHcwrdsHcj1MEkyOxMWIW+VFvBUqESMqd/ir3o0ZyF6y1mrUlJf3zEoFdYDjxwCJifWKs1sNyNofocazrggQYZ7dPvkPodr0UPYLPqGGVSooVCXoBx9i++4xdKxVd7Y6A8JBUmT42vA0iib4yPTtyveywCb/bRmh475IsJRrnnSX/9x5nAPbeOXAibIHPlUzDRfbn15C9ai7eUyaZ6ZeVaApKFWSPmnBdXB3oAQSFiyRAlf5DrSjG24CDksL+a3rAXNAmJlo9InNLx4j6d/mFZgo0GVN7RnijemWcCfGQxLVxMHMhi65EqTS24oKybIFCFAJgczMNzjyHMYnDumzAodfPs1WJgd/zUO8mpcPMNHyqF
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa370018-a840-47f1-4691-08db710c9cde
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2023 21:31:58.7892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KAXCUTbYnFzYNe6crvEKYACsRWos4yxmbLSoXGcaaT5UJxalmKmDpeiTq6etz6crJMoiakLLQ+ZWwo6fp26ofA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5549
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-19_13,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306190198
X-Proofpoint-GUID: V15a_M_S9q8DXdrJBWmst9hmopUH5p8U
X-Proofpoint-ORIG-GUID: V15a_M_S9q8DXdrJBWmst9hmopUH5p8U
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 19, 2023, at 4:19 PM, Trond Myklebust <trondmy@hammerspace.com> wr=
ote:
>=20
> On Mon, 2023-06-19 at 19:54 +0000, Chuck Lever III wrote:
>>=20
>>=20
>>> On Jun 19, 2023, at 3:19 PM, Trond Myklebust
>>> <trondmy@hammerspace.com> wrote:
>>>=20
>>> Hi Dai,
>>>=20
>>> On Mon, 2023-06-19 at 10:02 -0700, dai.ngo@oracle.com wrote:
>>>> Hi Trond,
>>>>=20
>>>> I'm testing the NFS server with write delegation support and the
>>>> Linux client
>>>> using NFSv4.0 and run into a situation that needs your advise.
>>>>=20
>>>> In this scenario, the NFS server grants the write delegation to
>>>> the
>>>> client.
>>>> Later when the client returns delegation it sends the compound
>>>> PUTFH,
>>>> GETATTR
>>>> and DELERETURN.
>>>>=20
>>>> When the NFS server services the GETATTR, it detects that there
>>>> is a
>>>> write
>>>> delegation on this file but it can not detect that this GETATTR
>>>> request was
>>>> sent from the same client that owns the write delegation (due to
>>>> the
>>>> nature
>>>> of NFSv4.0 compound). As the result, the server sends CB_RECALL
>>>> to
>>>> recall
>>>> the delegation and replies NFS4ERR_DELAY to the GETATTR request.
>>>>=20
>>>> When the client receives the NFS4ERR_DELAY it retries with the
>>>> same
>>>> compound
>>>> PUTFH, GETATTR, DELERETURN and server again replies the
>>>> NFS4ERR_DELAY. This
>>>> process repeats until the recall times out and the delegation is
>>>> revoked by
>>>> the server.
>>>>=20
>>>> I noticed that the current order of GETATTR and DELEGRETURN was
>>>> done
>>>> by
>>>> commit e144cbcc251f. Then later on, commit 8ac2b42238f5 was added
>>>> to
>>>> drop
>>>> the GETATTR if the request was rejected with EACCES.
>>>>=20
>>>> Do you have any advise on where, on server or client, this issue
>>>> should
>>>> be addressed?
>>>=20
>>> This wants to be addressed in the server. The client has a very
>>> good
>>> reason for wanting to retrieve the attributes before returning the
>>> delegation here: it needs to update the change attribute while it
>>> is
>>> still holding the delegation in order to ensure close-to-open cache
>>> consistency.
>>>=20
>>> Since you do have a stateid in the DELEGRETURN, it should be
>>> possible
>>> to determine that this is indeed the client that holds the
>>> delegation.
>>=20
>> I think it needs to be made clear in a specification that this is
>> the intended and conventional server implementation needed for such
>> a COMPOUND.
>>=20
>> RFC 7530 Section 14.2 says:
>>=20
>>> The server will process the COMPOUND procedure by evaluating each
>>> of
>>> the operations within the COMPOUND procedure in order.
>>=20
>> 2nd paragraph of RFC 7530 Section 15.2.4 says:
>>=20
>>>    The COMPOUND procedure is used to combine individual operations
>>> into
>>> a single RPC request. The server interprets each of the operations
>>> in turn. If an operation is executed by the server and the status
>>> of
>>> that operation is NFS4_OK, then the next operation in the COMPOUND
>>> procedure is executed. The server continues this process until
>>> there
>>> are no more operations to be executed or one of the operations has
>>> a
>>> status value other than NFS4_OK.
>>=20
>> Obviously in this case the client has sent a well-formed COMPOUND,
>> but it's not one the server can execute given the ordering
>> constraint spelled out above.
>>=20
>> Can you refer us to a part of any RFC that says it's appropriate
>> to look ahead at subsequent operations in an NFSv4.0 COMPOUND to
>> obtain a state or client ID? Otherwise the Linux client will have
>> the same problem with any server implementation that handles
>> GETATTR conflicts as described in RFC 7530 Section 16.7.5.
>>=20
>> Based on this language I don't believe NFSv4.0 clients can rely on
>> server implementations to look ahead for client ID information. In
>> my view the client ought to provide a client ID by placing a RENEW
>> before the GETATTR. Even in that case, the server implementation
>> might not be aware that it needs to save the client ID from the
>> RENEW operation.
>>=20
>=20
> No. I don't give a rats arse what the spec says.

The spec is what we've got. If there's a problem with it
somebody should document it. I'm citing spec here because
other server implementations might be in the same boat as
NFSD.


> I'm telling you why the client is doing what it does.

Yes, we understand why it's doing that. We read the patch
description for e144cbcc251f. We agree that close-to-open
is a desirable thing.

But I'm not seeing how the updated change attribute or size
is helpful in the write delegation case: a write delegation
is supposed to prevent changes to the file that the client
is not aware of. Can you elaborate why a client that holds
a write delegation would ask for the file size when returning
that delegation?


> You either deal
> with it, or you don't, but we're not changing the client after 20 years
> of this behaviour.

More like 10 years. e144cbcc251f showed up in 2012.

Neither Solaris nor NetApp return a delegation in this case.
They simply don't bother, there's no looking ahead or any
other such behavior. We've already round-tripped with the
nfsv4 working group, that behavior is not compliant with
RFC 7530 Section 16.7.5.

That's why this has worked "for 20 years". Linux depends
on non-compliant or undocumented server behavior for this
trick to work.

If CB_GETATTR avoids this conundrum, then we can re-prioritize
implementation of CB_GETATTR for NFSD.

Seems like CB_GETATTR would have a similar loop, though:
the conflicting GETATTR would trigger a CB_GETATTR and the
server would then return what the client already has.


--
Chuck Lever


