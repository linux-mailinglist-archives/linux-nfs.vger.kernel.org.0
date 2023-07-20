Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73FE75B127
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jul 2023 16:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbjGTOYD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Jul 2023 10:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbjGTOYC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 Jul 2023 10:24:02 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63B4E4C;
        Thu, 20 Jul 2023 07:24:01 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36KDdqi2021282;
        Thu, 20 Jul 2023 14:23:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=JrLOx3zVTnE+HiLsCs3zZ3IF4/QwIIgoyTZOCVQvIvs=;
 b=o+iX4HBF/8S4E+giw0nGT7kduC3vL8mrCmx4MdDl5Qy8hkS9a/mW5xm1uHmAalm7YeGV
 IYB8ZsSIzYLpCI/k99JBPT5Ku6roTFiqqRP5Qvh7+x87oCOw+QmlT/9gwiA/g6/RvXL/
 1uV4JGmHibopfYqqF9mxE0Te/mUZnRslgw4kLEiCAl4EyIBj+S+6WQOSfF3I57x/xnjU
 QlxcIxaKrzRk0sDPrglWIb673dvgkQWzjjkaZ/uvn+wzlM8NQWTWxP0/URZQMxWOBZiP
 AsVdpZnxv3AnBXinz095mK33sSkBhQlUSvQPxUiEO4iWinJyWpXOzbfkqUwSKp2RN0gv cQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run781v9g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jul 2023 14:23:53 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36KE4eZu038185;
        Thu, 20 Jul 2023 14:23:52 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw8qrbe-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jul 2023 14:23:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a+I3D2kPIOLeN4vaECkBQYlnW3P80Vgr+KLhfrCRitIw5DbDjCQMyJsE1fWDpDVnhdNrYsTLTK5Da7wWmEkD1qBP3yGHi0hrSawSRcCLIOAcDo42pUT+x/5ate5ibbRy0Z0F1phUMlmkABza4AE4YkzsixmjabOFdkSokslE42AArooZNrk6mzaSh5jgot5A5eYtJeA9lYoGaOsTrqpqYlO1CHAP7uGSMJUVPWFXQCLgjfgKXcxKUCbu29yzkxx0n+fDOnQyFjosUtkjHtExj7ydjAqCAIQzl9pbhHrOOQnpquoO4eNwlAyOlmC7VBkXIldQkAS9CjF6jrCW6qLalQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JrLOx3zVTnE+HiLsCs3zZ3IF4/QwIIgoyTZOCVQvIvs=;
 b=oDNpSrbXhbs1Y1ZJ+YUo8W9Y3gD7tnjdgdwJugkDWmDddjQw1vu4OU6Fe5xi8WriDB1F6qdhvtkLqJhjaREG/FrhUMxSWqjLz9JcA0asIeOk14+fFn9VTMLnIUpJTCdtdLH1dmnAwIncqxEAc3AFqUS47j3aZd/I/23l+tDa3SYPNT5uMga8dyPAdjTDD53v80zxEGW8AS5SUeXk+zo94me1psqW6wPffPg/MytMcDHposkH/fi3bwPyB7mZvnzkz3Iabe6Hze63rqvqbpkPA7qKdgHhabKXad8ytnhH1xMg3CBKek+KAIK6y0EUucS5SgTMi/tXYPXQQbLg1PhPVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JrLOx3zVTnE+HiLsCs3zZ3IF4/QwIIgoyTZOCVQvIvs=;
 b=iLF7JzOd/G23ihhE/xVhjG0+mUXbmKSCcafksO0EnyRyLvszhufhlVN24aGcONx/x1wSLX2ZrI5eHPFSJ0nLuxP8SQd9lKszMBOe0P00Vlhnl5oM+BkkcdKX7ffAU36BMvUBD+N+anJuEeTGmjgaW/9J2qjLiO5GhQugbPwzV0M=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB4907.namprd10.prod.outlook.com (2603:10b6:610:db::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Thu, 20 Jul
 2023 14:23:48 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6609.026; Thu, 20 Jul 2023
 14:23:48 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nfsd: add a MODULE_DESCRIPTION
Thread-Topic: [PATCH] nfsd: add a MODULE_DESCRIPTION
Thread-Index: AQHZuw78BoqwhoQa5UGLP9PFPNB0t6/CtW4A
Date:   Thu, 20 Jul 2023 14:23:48 +0000
Message-ID: <8D39A2C9-D10C-4A3B-A1D4-1F37D25E1D0A@oracle.com>
References: <20230720133454.38695-1-jlayton@kernel.org>
In-Reply-To: <20230720133454.38695-1-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH0PR10MB4907:EE_
x-ms-office365-filtering-correlation-id: d9cc540b-4e9f-43ce-c50c-08db892ceeff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sDbt5njGIHcddBQRpqqCN1I1bx39W4hsF51vWy6PaG3V4ZNNz0k2W2sHpN9MI7vxV3+oJTsnIVA6RVb+BFfvFo18QoHsfRRQii0DiVnMYvc6+uYf/3CUQ5BCCTQuyuqWk+s430K6Ztuc3KaJIyvXATM2K/r2DFvAikY4gMorsoPiN7woI769yVsfDdiHPyzlbbj08+8vX6JTg98Wa3vO83YpqAn7f+uYvZYIe2K5ucg/EPZ+7fgojjrU+8cPBjHvVueQNXhYtsxqLDG/dwqKQmUqle4n4V8SFpWHZca7Ii5q8agpfjpDZxUI4xyA3UEG3jk4DfDvTpdfD+q9CxyJy2yJJAoB2HhADRTWo3puza1u5Vl6pEoxH/ZqcrC7QTfxv+wNTTomk51ANddbsTrAC6asZUrcMj3EnX8WZFdypEQprcRWRD3LItcSpmhiR9CX2ZltstlaLk7gG3bRZkCUCVPsaTewrENVj9ZKsFPg/mP1fPGEHHflG1xWsEYyuPBBreMneN68XJ+73nwZixLvqffxsS64LWxcBMd+Dhew3br6TYFuhhSjBux2sueNZzbDFLiCx9ZAVIBNbVpR7mI4DtcsVQCzRLsBUmEQNSBDbM6kTdy0u+wjYSWbqDqMMjnhipBHLCqzm+EaZQaYmjybTw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(376002)(346002)(366004)(39860400002)(451199021)(86362001)(36756003)(2616005)(33656002)(316002)(4326008)(6916009)(6486002)(83380400001)(6512007)(38100700002)(6506007)(71200400001)(122000001)(26005)(53546011)(186003)(54906003)(38070700005)(478600001)(4744005)(2906002)(91956017)(66476007)(5660300002)(66556008)(64756008)(76116006)(66446008)(66946007)(8936002)(8676002)(41300700001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2rlwDNv/bMhHzkThdGqBHA1JeP+nV0IEFe+6lpd7nUAt3Ae7XUMo3ED6xMuq?=
 =?us-ascii?Q?UKNgsw3ufHEJbyS+lgTp/P6gBzqoPGZTs7ebzyF3vHvl3ygD3H22Rplm/4Kh?=
 =?us-ascii?Q?URItiShuKFiW9VH67EetWRYeIbFXxR2VkWTBPAs3O4F/uKjwfH98UsEc4iBp?=
 =?us-ascii?Q?TqzGcMLHnq+vppMf99mNMIopI3/a9YNFa6iOV36wZDjZomH7CO8Ynun1LOTJ?=
 =?us-ascii?Q?LuRWD3gVztO3xeD0n+U9QgiAU0ee5+JvbrhP1h3jAzDh8l6l2Y5EhabKHeu7?=
 =?us-ascii?Q?74od56Y1RGfbNelkDC6YppFUvUTbow4DcCJ+X/UhmSSFq/BSv+5GA5oXa8oF?=
 =?us-ascii?Q?gWOUquNV4P9D7kKJqn/1fMhUsOun71HlRtaJpqqN6DpCyKakYjbdkEh4n8YU?=
 =?us-ascii?Q?0AVr4owCXf+tlZ8HQ2A93uAiVrweJUT9/6NbHM6ZBQHQtnEPJ+aI4nC7zGNG?=
 =?us-ascii?Q?Ku7aLRp9Gy8Dmj8jPBXLvm+evmi/5bBLh2EOQoayxvq5aYvZAEO8YaoAreYS?=
 =?us-ascii?Q?oi2pdwkHm0C+Typa1z6fT6gQUGw9CTo4TdvJvwJgQeFs7JebW2iAfWIGCJHs?=
 =?us-ascii?Q?PbF3iVg8njCQAI/wgs0CSJDA7Ax7BavMrqv69DIC2Aa3MUU3Nz8/a6ddVquZ?=
 =?us-ascii?Q?Q0Y1jmF9aeUaMjd2X1vZH1mFou8g0pB7ulbMu9Jyk3UolRe3gu9/RKv8FGOk?=
 =?us-ascii?Q?noSNLyR2l/FWqozDwcgMTthqRXfGoHgyvgt8f7plZVBfAmb2vNVixUPgOcwP?=
 =?us-ascii?Q?5ywlk9Xn0rlojribYs3+QXHUTfzCC8L/OnWcfrLkbAk/RJ9vYwhZZaGzhVz8?=
 =?us-ascii?Q?tumOeJuc8n+hco4RaMqotsSoFiL+JnN7KmwTHpX5bSi3A4fJVOpAH1bW/I20?=
 =?us-ascii?Q?YDkDglNHdqWQF3DvzG2jETjiECMGPlwu/lEY9zd8MItQESiziHMXAqFj3BEm?=
 =?us-ascii?Q?N3kvQ2nOOdFz38lk6JVODB0A5+E0oaWm3moyBvudr5uHEvRCtDQyTHW7MqsD?=
 =?us-ascii?Q?3mBcBuZJ8RV7O029wr67uQnyOBfzP38AAdAMd+E6/wxOmRMPIUhZh4/dEaxv?=
 =?us-ascii?Q?jNfiuERhmr/sUJyUO+AR8RMoxXfqdLsvFQPGLbvuZJpd2lFkVps4hfSruM6V?=
 =?us-ascii?Q?FU5U6g2ChqKeY9lC3+FqDTfgyD4m4b6V3iZHWt88vx1ZusMo52/w3Vmq1gzx?=
 =?us-ascii?Q?QitPaWZMQ4zRfbaCduFpMUtrleUb/O8fAMKz3naLkgIIv8dfFkMF8t1EVYAb?=
 =?us-ascii?Q?ELW0dFstRySivL8MSOI9fzSY0v1/+pZ0ooEuD3vL0i8dlwcxCAIgDlxeWnis?=
 =?us-ascii?Q?UB/C1klKC+TCzT3JRSs2pKjLBpZYO9hPStK02DPSnq2e/QU04LU1EOF1AVlW?=
 =?us-ascii?Q?ZIFXdmFneD532x8lIfCEIA2yA2hAL3Aupu2/wPCW13kVjk+YbPbMxHB03MEH?=
 =?us-ascii?Q?m/v/3R4bvwTEqThycZWCqzTTCTHduoMy2yWU45dz/gekuxrETtzjY7i006yT?=
 =?us-ascii?Q?kbNLF/VW4CpM+wyYba/WIrYluDIzLNq6VBDoRaRFBjoZSGVP8YiUs/NJ59ZK?=
 =?us-ascii?Q?tnDWSKcYZvNZyaNKF1WkAi9AUwciXgjzTHmDdj4GPv/fBjPsR8ATmXHUqpQq?=
 =?us-ascii?Q?Rw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A634AC50B97EDC4CB5EDF6033D4C6D49@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 14CGe0REmsAZIvMD7ZTvdyImFHnPiqR+bZyG7UiC7L1PrLF4Fl+uv1I/f0IKWTbOjROixAv8sgIWYlbxnuUhOutPYyZOZCX1n838LgUlblSIicnSyOB7fwxQmm2FnjkUezC842vVlIuJyzjTOsBPmBzuqbzBq14Jp2pCK8eJZJ8qS4wxgBj9vTSgl8jEex14FWZ48Cn16cxe3uxFXvPOUSRHiMxyS+mN2kHYIpaER8FxkFztwirKdifibYx5fkENATIG5na0ZDLzBlppp4zAQeZP+I0SDtdpBD88heSLVnuiAMUJ0f83drdT0mTPVyyaI260pUtcBGq3Mq0fUiAYC3WsEhFdx78b1cJfTZjr/SmeOkKDX58AHxkoyWw5TkXRaSFpEMj30ucNElhdg+7/+vx/Edu4od2DO4ZSOPHmqSQSF9XOeK2RZ3HRuahfmMAnK08q4tAa8/iYEKHKnzqMRCYO26I06PATBGFWjqoOGofNbaWF3sZe0OiwNE5iqWG9pzBHE5u7RDUB5Jz601TZ/WqP7zLSKAdOT92xvjP/yXIt8LBJNKXVG5hyBTybb6ZLje/1LgjvdUBvtF5Qv3pwPYsy4xISfGY9wvv1tyRacKZlWW7jiPC91q7Kg/jZvsNitehIOTnxXdUMWMFq70zscI2MR3ewwkrEnMtSGc5yk9PI0/I5eXvv5PCJsZ75RPPEvKqdPqN/kCNeDos8zW54j8GDoQnB05hRX1sZ7lynGqqS1Kk+Oxo5nigieWV3JuDdW5kXTwHL/MCCJ+t2KiFxzd5ruxa8FRvH30pKDnzxkplF/p7FSSFDYhZDAxIMPOUPKd1owD0F8riSXa9rB3LMxMW4Vuw6x1pTnUWYArrZlz0+kDZxrsUVEs5JKrZWaIB4
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9cc540b-4e9f-43ce-c50c-08db892ceeff
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2023 14:23:48.3868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HPrhQdFWvczgRztArUoMqOdEYHL4lpjojkSaqPwhBG/WFBpboxDyPHfeSM/VmwQ6m8IPrn0zn9niPUJuBetjcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4907
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_07,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307200121
X-Proofpoint-GUID: JRFcz4XljRCerSqWbE9YY_zI44QCuC2R
X-Proofpoint-ORIG-GUID: JRFcz4XljRCerSqWbE9YY_zI44QCuC2R
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 20, 2023, at 9:34 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> I got this today from modpost:
>=20
>    WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nfsd/nfsd.o
>=20
> Add a module description.
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> fs/nfsd/nfsctl.c | 1 +
> 1 file changed, 1 insertion(+)
>=20
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 1b8b1aab9a15..7070969a38b5 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1626,6 +1626,7 @@ static void __exit exit_nfsd(void)
> }
>=20
> MODULE_AUTHOR("Olaf Kirch <okir@monad.swb.de>");
> +MODULE_DESCRIPTION("The Linux kernel NFS server");
> MODULE_LICENSE("GPL");
> module_init(init_nfsd)
> module_exit(exit_nfsd)
> --=20
> 2.41.0
>=20

Applied to nfsd-next. If you have a lore.kernel.org link, please
pass it along and I will add it.


--
Chuck Lever


