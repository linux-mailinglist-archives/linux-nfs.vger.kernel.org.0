Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820265831E4
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Jul 2022 20:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234392AbiG0SWd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 27 Jul 2022 14:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234481AbiG0SWN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 27 Jul 2022 14:22:13 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D52BF1D9F
        for <linux-nfs@vger.kernel.org>; Wed, 27 Jul 2022 10:21:28 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26RH8usZ018368;
        Wed, 27 Jul 2022 17:21:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Htn0as8XMn48jxzh5jnU95VPcHHDN4WvEhdxaAGgl0Y=;
 b=XbWHc3+Gi8P6cx+s3uZ8Wf5xwXpGefvMKNeh45mg8lslepI1Hwk0Qkquebvl8iq3D8e/
 r+jWwjOhsSu4qzN69oTHyE6gUPHyBp9XMXX7sMCeoHC7DBWHXdAEDpeZLyHzdgGwHdJV
 mgL9kGyKrngWPEJhhALJRN/7L2Obdj7vahQDMkzdtzl7pJU8UfiPvgZN1ULGwsYoEoWY
 DfRhJg43yHXYp8Q/f1sejPplBrlWgce+FZSLYueWihlLTauUftKgQ1VbFqLGJhze2z3A
 hyUf5YP+CORDeqJuKZOxIBOSf6dCkzOA5pNbLBCXHqtC+wQkZu2vphLkPXVqKn34xZ1V gQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg9a9jddd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jul 2022 17:21:26 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26RGCRCD006430;
        Wed, 27 Jul 2022 17:21:24 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hh65d91gq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jul 2022 17:21:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hn4SGoUbkF6skp4/6qRZKElHieaUr+bC+rTeGEUjv08FjLWjjklhwN4c98xSbLStjuYlVbJgzWiYNeDY17XHlAjQigQfitaNf0uQVjI7W7EOJbrewQ76Ns3e4a68FJtDYrhSKqVpUbuAM30QXP6dR28aE8w1g4nOcR9MBG++f6TKAPp2OQb/6lyx1dnR677HErAwY/8PKtsyRjMlKjLfKELur9R9S4MZd93HwOteWzC1KUnp5SEi9LKbLN4CmLn2Gam5mg0Yzc5su7UhT/YV7eFnN4wUmJ2z/LS5xZlZbAxBgCHb4tfLUdZ5IJY2BZ/4LLRNKWin8QJwoTE9Y4gAzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Htn0as8XMn48jxzh5jnU95VPcHHDN4WvEhdxaAGgl0Y=;
 b=F1UqfpxirFeo2A/wWS6zy9ddsBu/vjLp0/LqziyIWhNH+775627wyjpKGX50OdnTi/5ssTGFgUw0j8YDkKYeggfLdpq7E+Wgy79zqpxBh0PoWrdwxPPrnWY05iEzG3cwxJYD8QbuevdS/LcxN+YksMbgtZsl12pq/1mCgv4t62CiPBRyyGjgrNonW4rxPBAN9fwcfBt/zTSJiTKmAEGjskYrqxL1jvJ+D+MG7m1BON/XUvDWEDrORTwVfgI1m9BhPinIvLH11sUohT9mxnJB9Ym+G01FQ5f7xWJW+CtErb2iX4ujCDJowK6+zfUfr96lQglqjJqdLszPR4d9PNyY/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Htn0as8XMn48jxzh5jnU95VPcHHDN4WvEhdxaAGgl0Y=;
 b=S4wPeR0ZgE+xMNTlIGTHEgL0/543qTgsjWqS1jZMNf+wm+t96bxMZsFoAWqIqiH8HgCDpRhkukdFpMn5Y3ltKrF9GPCU7cGTSF/QxLVllW7a0F7HgbcyKbQxDXqBl/zj3FRW8F674emBNUWo/1UQ/bZDomhQkl0Ew89IDdaRG9U=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB4774.namprd10.prod.outlook.com (2603:10b6:510:3b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Wed, 27 Jul
 2022 17:21:22 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6%8]) with mapi id 15.20.5458.025; Wed, 27 Jul 2022
 17:21:22 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jan Kasiak <j.kasiak@gmail.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: NLM 4 Infinite Loop Bug
Thread-Topic: NLM 4 Infinite Loop Bug
Thread-Index: AQHYnGkqEuWV8f5/AECQUMNmZwRFWa2Hrj0AgAk/5QCAAAUVgIABjjmAgAAAUwA=
Date:   Wed, 27 Jul 2022 17:21:22 +0000
Message-ID: <E3BD2E62-4502-45CA-ADDD-96B4EA4D2629@oracle.com>
References: <CAD15GZd=sxsXiNmuN-FpRk3E_cKRF_CTLqxd5XJ4KhtON4XkPQ@mail.gmail.com>
 <CAD15GZe1__nJ6SfAr1zs4Vq4za9D=FP__SotyS37RVh=2OWu-g@mail.gmail.com>
 <CAD15GZdCYTr0Xfn1-n-aXf5FxLDR-zrYR2TutHk_4RRbP6+pVA@mail.gmail.com>
 <14F384C7-1900-408F-9289-05173A8C1BC1@oracle.com>
 <CAD15GZfOqca-jBN11o2b6iVeWU5hFXXB6oj55wYEWWgwK6VKdA@mail.gmail.com>
In-Reply-To: <CAD15GZfOqca-jBN11o2b6iVeWU5hFXXB6oj55wYEWWgwK6VKdA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d13ed4ab-9510-40d4-9d23-08da6ff46d93
x-ms-traffictypediagnostic: PH0PR10MB4774:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wijwRWrVzHHMQN0dI0vyHn1w004Jpk4aALL8m33xBo6XABaS9U30J844Xm36EJNFoHvQvX9NYbCKnUSUc17YDmUMjWJLvt89BcmrqhjLqbrP0VpOvsvZT/liOcdV0nK/MHqd4GwvbKHJH7KLuYwl8AqcDwUyRRBlbx8adLqZI3WUa8x2I8qacU3H6oD1FsvjOlgIPl+qpFXpycVU+DXY/5zaYOsWvX6v28nbzndi/frRQ19nevxn8sdArZbET+bd9uejp8Uqwvkqnvj5Ac+e73CV6fC9cz3ASK8ddnF8F42kRy45Lx/mywsdRXlg3tw5U3t/GgYFSEe8O/hDnO50yCCxcEAYH2AV/rfA38HVOgWwvEuELMME1OI1W+b3ehwAIbJYuEMxgry747PlaVj1lnNodEeNg8QmoUBEcWdqH0oK/t8Tsm8FlTxKHfubG92n1+4DpKFLm3U6c2ZwqYuU6ygvXrCRh4Dusgh4pJ35nQ8JJv0qShIwLi/Z6g8g3pvqDghCRXQlVtlXKhLnbYnTOftq8vzltF7D3QiqQM0XTIokgZ/KFdGgu0ix+jvAwfpL8QH44qzSy1CyFzNllD68t7NPzEqDiZ1xCF2KgSMGebydmwZjpCJeoHTUtklysQBNn7YSPZ6RIhQwlg2tqFVYuP9HAUi+AUWWgldz9CVjTZlpdX0TIVY+7oUUI1meo/Uz1SL1lYUgeMV5kYTOHZMawv0AM0upRXmQhcQ9vK5G9+scPcFMEuu0qT4sI2FPk6m5l1cyJ0t3bulmmmK1iNTBJ9+oYF9UU1b8nG9kQ6OJ2kcpY/Q6Nt8ZjHbvosjYdtzC4BBvFOQi2phQiVq2IFkrPtvX8R9TZ5o73fY2Ssm1q9uWogY/wpLJh2uCE2M7XOwdGK5wa3T2Y43d3SR7miP1Iw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(396003)(366004)(39860400002)(136003)(966005)(4326008)(316002)(478600001)(6486002)(2616005)(186003)(8936002)(6512007)(6916009)(2906002)(33656002)(53546011)(86362001)(71200400001)(41300700001)(64756008)(6506007)(122000001)(26005)(36756003)(83380400001)(66556008)(38100700002)(38070700005)(66446008)(66476007)(5660300002)(8676002)(76116006)(66946007)(91956017)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xM/1oHI7LlYzRiRfN0WRSTC4CfWL03wu5iSBQ798iHJtzQQuNfNri5dPP3fc?=
 =?us-ascii?Q?Y8q0EIwL96JCvu2nCnrKlIETb3TX5r0B/d+hJNWxeIhlCMpSUvghw73D8EBX?=
 =?us-ascii?Q?Itt6y2+driZeQIaeMZqMiSl6N7trzNR0XLhWSlezBTcGyZmE/xE3O/C123tj?=
 =?us-ascii?Q?ffSDtQpA6RRHpEX3rRsJd7IZjvHGNSexmAD0LM/Fu7BKNCkdTeya7emqwzNY?=
 =?us-ascii?Q?iXcWv1lCvTD6LK/j2YK0k3m4akBNBvU5p1QV4CBSXX0M/yjRlx5qdPuEC4Ww?=
 =?us-ascii?Q?xsaQ8fWsabXHoskz19985I+iG9zXU7fl7XuAK9HryHEXU4usqQW37TuJEWGa?=
 =?us-ascii?Q?y/RwoUYCXhnfsVelvEzAZ8Bu8G1kIOvvVuWSHnOak04jt7SSrX856WASSFkd?=
 =?us-ascii?Q?lb9GsWVq6AHq0rMNmQhHo6HGtr26J2XnlSV0vfjbtrjotREWkOvv4/oRhpKM?=
 =?us-ascii?Q?Z/QSj3+c/iF2e0HjABviaST+LB1Ok7CLwwqFtH+JS3EfBq4CWwo/iKBObnSi?=
 =?us-ascii?Q?YtIsNTVTRlJrDolssckDwPQ06eEZRub6Mu1k8utD0vDhBSQNMaKAJlQ2MHro?=
 =?us-ascii?Q?MD79OTYLaDmeb4CdWHy71GLztkQrcr2NKA3gg0Do2AQ3m1jj0UdbfDc72mK9?=
 =?us-ascii?Q?gFcHLTEHXYfYvKiOUkE6/IwHJFmtv3Y2PIBZ8EV3VfFzXsTgVtyLrugpA7oe?=
 =?us-ascii?Q?4GMXN/C9SEydt/XgO80Ba0RL8Ak0y1NwLkFL8n5lSnrJ5q+kQ0svGSPyWsgz?=
 =?us-ascii?Q?G4RH6ZJzpHpp4WvcITH/UQFD5vcYVf7zaSufzSZ6bey95yKbHTcRHQqX6F4H?=
 =?us-ascii?Q?y9yPtoEw7GNiExct+gkKMF/8n4gYcPCdlJlDakP6w79kONZ2gviGcb23s5rF?=
 =?us-ascii?Q?n0GYyRIl6ZzS/YEOf3hj5nuoA0gXtnRN1VjPU63gxeTsGY2LhfGHn2cKg8JF?=
 =?us-ascii?Q?GEeoDmJ8b0MiNVvMMRJeLDuu+jiYY3Ta4pRd1Y8MxKUypaC3FfhUYlg64dVE?=
 =?us-ascii?Q?MZW/jPlg9q+cSFUREGKCtOcAlnsoO3OBg+1GJeJn8dWeIOfGF4DDZ5rDSnWY?=
 =?us-ascii?Q?mluhNiYZrZ76sBhJ2GPwcu5MJwjLl5g2sNKsBJTOlR7HAR9u0YVyCZt6SdOv?=
 =?us-ascii?Q?XlozeWjM+z5JH1qbTkMBlqZ7sugXYU0S5VtK//+DWmmbYFw/HUHlUSm495zS?=
 =?us-ascii?Q?kwGulPcS27+6pHMG4gEtTps9LrZJqUHjEDDhXI5YsBP+iTnR+m8w6Q0Z8pJT?=
 =?us-ascii?Q?wRC4YYgb0co142B3kjMivx5T2CJVj/aapWVXrCAUTtaHcWgcLgaegkmlJe1O?=
 =?us-ascii?Q?duV3Y4zaVwcPrGFsLUs7hR97tG3U/PgAkctsPI1KDIxkXeX4XsDn2YVGz6G2?=
 =?us-ascii?Q?tT90EFKdBRGakOoiWmiVuL9N8JS/9reXPNgL4nWPRz3uWUPrhLM2wAkl4nrL?=
 =?us-ascii?Q?/Qv0FehlejKdHJcJNjmLjcAENyOP7GHQvMPdpXkEAGkipq5ydZEPtiaBsrCr?=
 =?us-ascii?Q?nc9oX0J6MbX8IH2yFiasy49WgtGPqPc3r3W+EmHUt87w2YPu/LplwyBSAgN/?=
 =?us-ascii?Q?ElyPIzEALf1B5pMR0hNpUVyqrVORzSUDOlzgGCePhoqZQdv15J1Mv2Tiy1kY?=
 =?us-ascii?Q?1A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DF1BF75362C56A468A8512AE219752D1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d13ed4ab-9510-40d4-9d23-08da6ff46d93
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2022 17:21:22.7284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Of8hBs+I2lThRiT35fsqBQPLniZKSAZL0ebyf2+shUKuKGleAZfqzqYaRLLeVEIRkXC+jBe0yxAcCX2qe85q5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4774
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-27_06,2022-07-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207270073
X-Proofpoint-GUID: SddCfWexpcJlmBKMrbtED1hBD6m1SaWl
X-Proofpoint-ORIG-GUID: SddCfWexpcJlmBKMrbtED1hBD6m1SaWl
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 27, 2022, at 1:20 PM, Jan Kasiak <j.kasiak@gmail.com> wrote:
>=20
> Hi Chuck,
>=20
> I created 3 bugs:
>=20
> https://bugzilla.linux-nfs.org/show_bug.cgi?id=3D390
> For the original issue I reported with FREE_ALL
> because I'm not sure if its fully fixed.
>=20
> https://bugzilla.linux-nfs.org/show_bug.cgi?id=3D391
> For scenario A
>=20
> https://bugzilla.linux-nfs.org/show_bug.cgi?id=3D392
> For scenario B/C because they are very similar

Thanks. Jeff and I will have a look at these soon.


> Thanks,
> -Jan
>=20
> On Tue, Jul 26, 2022 at 1:34 PM Chuck Lever III <chuck.lever@oracle.com> =
wrote:
>>=20
>> Hello Jan-
>>=20
>>> On Jul 26, 2022, at 1:16 PM, Jan Kasiak <j.kasiak@gmail.com> wrote:
>>>=20
>>> Hi all,
>>>=20
>>> Even after applying the above two patches, I have discovered a new set
>>> of NLM 4 requests that break lockd.
>>>=20
>>> Unfortunately, I don't have enough experience to suggest a fix, but
>>> would be glad to test anyone's attempt.
>>>=20
>>> All requests are non-blocking.
>>>=20
>>> Scenario A
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> lock(offset=3DUINT64_MAX, len=3D100) - GRANTED
>>> free_all() - never finishes and lockd thread is stuck busy looping
>>>=20
>>> Scenario B
>>> =3D=3D=3D=3D=3D=3D=3D=3D
>>> lock(svid=3D1, offset=3DUINT64_MAX, len=3D100) - GRANTED
>>>=20
>>> test(svid=3D2, offset=3DUINT64_MAX, len=3D50) - DENIED
>>> correct, holder offset, len are (UINT64_MAX, 100)
>>>=20
>>> test(svid=3D2, offset=3D75, len=3D10) - DENIED
>>> wrong, because holder (offset, len) are wrong (UINT64_MAX, 100),
>>> because the above
>>> lock overflows during comparison to (49, 50)
>>>=20
>>> Scenario C
>>> =3D=3D=3D=3D=3D=3D=3D=3D
>>> lock(svid=3D1, offset=3DUINT64_MAX, len=3D100) - GRANTED
>>>=20
>>> test(svid=3D2, offset=3DUINT64_MAX, len=3D50) - DENIED
>>> correct, holder offset, len are (UINT64_MAX, 100)
>>>=20
>>> unlock(svid=3D1, offset=3DUINT64_MAX, len=3D50) - GRANTED
>>> weird, because it has now created a lock at (offset=3DUINT64_MAX + 50, =
len=3D50)
>>> not sure what the correct behavior should be here - FBIG error?
>>>=20
>>> test(svid=3D2, offset=3D75, len=3D10) - DENIED
>>> wrong, because holder offset, len are wrong (49, 50), because the above
>>> unlock has overflowed the offset
>>=20
>> Thanks for testing.
>>=20
>> May I ask that you file these as three separate bugs here:
>>=20
>> https://bugzilla.linux-nfs.org/
>>=20
>>=20
>>=20
>> --
>> Chuck Lever
>>=20
>>=20
>>=20

--
Chuck Lever



