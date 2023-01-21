Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C24D676792
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Jan 2023 18:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjAUREW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 21 Jan 2023 12:04:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjAUREV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 21 Jan 2023 12:04:21 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05ECA298D7;
        Sat, 21 Jan 2023 09:04:19 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30LE6A1P031342;
        Sat, 21 Jan 2023 17:04:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=JZDiyHd3WAhd7kztz0opBpYOMJAGbvMmDIoNr+sKoiU=;
 b=0zCCJmQcG5DRbkhTyGltXLhSIBtZixzQ9Iw/kysDMIBPLf3KFizQaUFyShlvDMRnssb2
 sGioYSjgI9+lj0L7B6QzBOAOlaPRm+g2fwLuwaKMNbTbku7LtNBeyFJdkSB964mYaZv3
 dIgh5ZXKOUKXuhBFeDKFhs5wl43mabMNAM+y78ikkk1OZXxRWeiuOrJoMTWOZujFWdMi
 QkkbXhwNAcjGoCnNJUMeCsqMxjBJFajJ8XWconjG4mTvW/42pqQip4EpIFeL3MhpKtf7
 J1fOXZVP474ADk265CVl7F67qasXaSBoa45qZ2HSwrqkypxpvnM1GkRSmfkXUb8uXOB9 ag== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n883c0krf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 21 Jan 2023 17:04:11 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30LGFPk1014878;
        Sat, 21 Jan 2023 17:04:10 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n86g87ugb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 21 Jan 2023 17:04:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FuZjQTamjDMYhFtkrYJ18LMeUOsi+aNyJVE7cl4qqK2+x9g1EajEFmH3ZtYuJAxj6+271AwdmmHBxSvW8IckZgW/cqsFARoEN99MJPtI9YhLA/gAP+zlYK32f/YsDhvDEk9UIoCnGcMeJkJV17pRmSnTN6K40BtxElsRJe5tozI4v3pHGvjpvAHVdh8xjR99P36NzK6omZpduLCI30odgDE8CSfZWnicAqVA8lz8G539egQeoaQBnD/ETfDBoZJ1AkmnUqUGs3K4Q/c5nYvZv1A/DIpgFQF1EcJGeJe2RIsyMdUSHBnIfmVVDJ0GT2RG6plpf8sIKnNBZNRmVD/4FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JZDiyHd3WAhd7kztz0opBpYOMJAGbvMmDIoNr+sKoiU=;
 b=C4l31Vppb175/YVYnSJ1cH87nBZNfjHfurXWNUqjVKt9dDZyD6R7hhVDZ7aYIwWeloYM0AKawqe/Iqe3od4eySHuDjpvBfFpoeDDcj1JTpjUbGdDnfl1l7YlYOfr+7znab1R24tMs56Eeh4aUI8PNRY8YhUEpFelhKjT2luMraDi0nQJzw8Wd6SEIgA4busp3ACcowjkK/hM47Q6IDBOYkNxrQ7/aAwzNekrVfVygnbAZC7MB2VtadoYpQQz2rA/BCWRUdnuhP+MFcRpYZ+IduthOaPv2OvLeJh5xwuY7oi+YulpCcm+EEj1w9q9GBPSGe8O3DVtvSorTgBXpXBi/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZDiyHd3WAhd7kztz0opBpYOMJAGbvMmDIoNr+sKoiU=;
 b=WtxPMjXLgwuizCTDlzvBUkVfByDUAhjybby36o+cVMDX8ZvLJyXP6PBl+m/P30IqmcLuysZ8QLN2ALnHkEyYThPPPZFa5rVNvIDTAYfWKeU+kh5+2KDnfKfE+XtQXJOZVD5prGAibsab6EceBvclnMJalwSPWJ5gSl8v+EZIhqM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB6900.namprd10.prod.outlook.com (2603:10b6:208:420::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Sat, 21 Jan
 2023 17:04:08 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9%4]) with mapi id 15.20.6043.009; Sat, 21 Jan 2023
 17:04:08 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Ruben Vestergaard <rubenv@drcmr.dk>,
        Torkil Svensgaard <torkil@drcmr.dk>,
        Shachar Kagan <skagan@nvidia.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nfsd: don't free files unconditionally in
 __nfsd_file_cache_purge
Thread-Topic: [PATCH] nfsd: don't free files unconditionally in
 __nfsd_file_cache_purge
Thread-Index: AQHZLQi3y7Mea6cMiE2cfMbyen4b566nv26AgAAJSwCAAVH0gA==
Date:   Sat, 21 Jan 2023 17:04:08 +0000
Message-ID: <3BB57727-27FC-4294-A5F8-FBD8E900D94D@oracle.com>
References: <20230120195215.42243-1-jlayton@kernel.org>
 <C04F7C2C-848A-47C5-9C4E-9B9E5E82BAFF@oracle.com>
 <d5dc64435fb82f17e79ae20a370e90914a291ea9.camel@kernel.org>
In-Reply-To: <d5dc64435fb82f17e79ae20a370e90914a291ea9.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|IA1PR10MB6900:EE_
x-ms-office365-filtering-correlation-id: 6a9ead34-120d-4208-3709-08dafbd18265
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u2tNI9G4fYKJv0Fdgz0h18cF2BKRce3yJ5/7BLU2plI6C34XP1kd6cYFS2iJXtC+UhojVTv+smgveOWgvIA4g8jkJ6FSJ4Ax1LpwBPLLT8bScJ6NtdypcgwjUhIO533QR47RsNr6VlJ8hsSbWC8AVa//jT7/fbtnxnS7bRiuzVzV6kvZHNGWWDU/joq3NJff0AH7ddkxCxYw32Y2BQFWaUTKl4a/2va1alM6HDgsAXEedcwP2iK8VniLu9ahVzqlj9O9a55ZxSDFkl/9ImCgtAnaFs4IT3C/XNRKsD1I7hBRLsf6AeDxHpd5auNkg+3KySCpmRNyys62+yh52qzZVNY1AFGUZ2GyVNTPKp0N3OJRcmMobiK3PV8sutWppr2nL80wWfSYZEWmmhHnwl/Ho9gLBPbr9gGXj5Kl3LFjP0Ba6N9tTBxTBryz47jxNVlwLQ5gQvGUMKQ+14Z8NSoLuuX05Yvt5l2L87Mk0ryfbI9rwdZc8kB9UW4ZMJb7hvBzec3yHNjXinF4hLn4dE8Pl7cvfvdFoC7wyj/8W+ewI3v+px+1smyFXtij8ZPewc9D58zJGlKZDbzvIakmEmq3vF+yUW8fit7eW3B/yASbjTDdnLnz5NymdfDFKKvQhNUPTtZtGYO1pOSnq7u7iRx40NmYCDwn0LIbUlJXs/gb8UITL5kTkQvYj0a5SAuZjtd/Vaq9z1GR2T/SWSdYf5eSXVJX7SSUFtO/OJTXujQ1vnE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(136003)(376002)(346002)(39860400002)(451199015)(36756003)(478600001)(33656002)(6486002)(71200400001)(86362001)(2616005)(8676002)(66476007)(186003)(41300700001)(6916009)(53546011)(2906002)(4326008)(26005)(6512007)(8936002)(5660300002)(316002)(76116006)(66946007)(66446008)(66556008)(91956017)(38100700002)(54906003)(64756008)(38070700005)(6506007)(122000001)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1coY3v5tIswUTpWBj9iUIWlbTZBKD0Tz8yEhcJoEVuJ4RlCE5Novt0Q/guiw?=
 =?us-ascii?Q?Rq/laAeWz6iRiyGVwKg0SH+0C0thRR4EHSefulvanRHrFeUtdRqkRN3FA9Mp?=
 =?us-ascii?Q?Z+BOG315deOkicxFN04ZjPMah9bscEB3uKYD+a/Y53DTvJXXeBb4xfQJYa8/?=
 =?us-ascii?Q?A02NpK8iRFW7dHyt5fw1lmIcJWjDkZ403DPiA4ChMTQsp8d+U/iVEhz/8tWe?=
 =?us-ascii?Q?YW6pZo/EQsfsDl+6pW0GWvYOTnli4R7ICKf71YbkpmORCPFsf5rEnD9HkfLI?=
 =?us-ascii?Q?CDNCUAD+5ubOirzcD40VHqkdk4flnckkEi/ZQ5fSnwcSHyMFWSwcJ1jTPX3/?=
 =?us-ascii?Q?lc7VaI0rHGzwTN/JmtX4ZLOoMuopGRHhhoOBSFTCqkY4HgAKb5a0ji+QW8+J?=
 =?us-ascii?Q?DNUM/om4QR59DzbJ3/gNh+V4C5mePvA5uBkUt+iGf7I2VcpIEKZZfhGj/Dis?=
 =?us-ascii?Q?/meRm+A0UvUxtjEUzTg/MkVOLpcnniR9QdWyT/g3N/kgQSczXv6+z6aDgYqP?=
 =?us-ascii?Q?0L2a+0mxoHyw5ecoLViFGTvNBgMYksmLLHhajxS7incZnyN8Jh5oSJ0J2gAV?=
 =?us-ascii?Q?9iSEMLTZMkU7BpvCBYyM+vIBDWG/lyUkGV6Tj2s8mNG2+aEj7TBJtgo5dDxs?=
 =?us-ascii?Q?61tKodSGm9qMGRWBkkPZSwjpTHL233EpJ4Y+BtiBnmbbhn9qGQprM/a4Ic3H?=
 =?us-ascii?Q?GpftFSV6F2U/lVAZ0+0k4wo4Gfk6x18qpN8+dSiLpf4t5RsjRXHHOzBjLbsS?=
 =?us-ascii?Q?g/HOFgwNNJf8Jc7oEEaidj3DrPSdZu5uzEAY15+XSXX3YfqcYn0Tv55gkiSc?=
 =?us-ascii?Q?1QlzbQMHSN7KF5OR1oxkLjT/f1QPQ0mXexJ6Ko28rmRucpX0ldVTnmz9yCfx?=
 =?us-ascii?Q?vXJRsNL27vu2ox9OwZoesl/gCNVsad0RgcHEl02H05QqGKMZU/IlkabQcVnC?=
 =?us-ascii?Q?gOTalaSd3u74Nih189k+P50BMgXm68ujfvOBwb/Drre99JRZHgBQHjCAKUSN?=
 =?us-ascii?Q?sHzFd5GpgrkME9Tnc3jcKkPwZxUNsj75eu8JzhstkipeH6rTVxT2Hv1ZTilB?=
 =?us-ascii?Q?fWcbT5Z/zLsv/gi+vzxQ1uWIClMp6TlVVtgLFwt+Ts5VAZYqeFsvGvUwOp7c?=
 =?us-ascii?Q?LgjCTK9H3A6GALpVE2ueW1XdNBDvb8fdmRiE/Mo9RqV00y9f8KrI9Vk/PLID?=
 =?us-ascii?Q?I4a4liEAi0WPCK1gVuxpp7yIIWr7J1ZO1f2gu40IBjgfAZT05I9LTevzQtxD?=
 =?us-ascii?Q?YPl6nHn4MowcNQ4OdvfQ9FPcbbAWs61nys/VbjpBsIcwuNziTyuXdNMvjCUq?=
 =?us-ascii?Q?wu5TYOLp/b8WkLQDxR44XJUict0x4K9mEcGYx3ja1vqtG5/1sjIUGKHP+fXK?=
 =?us-ascii?Q?Qla9giYQBJhtT01GRv5S4dbccDq7on+31EsnhDe7czvcHIyiv/fm9jUa8iQW?=
 =?us-ascii?Q?ofQ4DkQ1nucwapfdkaJAAQAduuEExwQ/qcxtyk168G1SjzWCFahoEfdLbBLv?=
 =?us-ascii?Q?BrvugRYYcHpPJ0j0LLJITbvxK0zV0C8BWStAFOcO1PAI7JTGQRzZLPRUE/pL?=
 =?us-ascii?Q?4xOANgf6Y0DFIzS6RTDzPgXNyIFSNal3cIvUXVyXY4Ot41wyxHCIzgEJmMoL?=
 =?us-ascii?Q?AQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <623E9813E67E3A4E9186437C700BDAB7@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1PRz/bfeEg4YefuHMYtqPugO7SmZjUyRT2fmp0xxI9LAEpiGnnZE+DTTrwM1hscugURmO+JLMPNddts48kAyYC8SxqPHvmbwDhwzxOYu0EIxI9DrBtIhSbVxuWTE0Nqrl5XDIdVH6DBoCO/AqsPorRkZkvT7aTrN2Xf6eQQDSZEovf+6sMnR0wvEBW7AeaC1sXp2quJ99rjn5pM1dAZ/2Qq9JAznzpYVsQAHarvkj0TAEYcMMgB7n7AIE+vRKinLqTvV/IfZzYPdVA00EFA1RuY8cU1icM9fAomVN4HZe0gpIGVctfARK3A5ZaPtcE9zQ3jzzYGshWyI569TLgSFyWjuF1rPjxDJeX7MbTrJ8SNaTlOSQJ9Deililtj4xPJa0t9wRJVEQ+TumBLTdZ0Qo7Qjih1ZkWUIBW0EX1JK/XLfS3RQZ0ZF2RG4VOsuX8ivLcT9tD69PcrGP/goEeQ6BPWYAgnR7EB2HIaS1K6gP+FUOtrekAVL3TNHRUJJ7M28h77jjh8i2CuByDmRuKv1PyOV6diRMbbbROzmNW+JxvZTiDd5Ep3hKYFgg0BeqrVxAcroJ7zVLfuoIkf5RixK7V9bk/dY6TFV6Bgfg4AdxHtKF/85xQgGfMU7sQCtCnv+Eth87pjkbqAoHNraJ2CdZByLv23mUasioVm/ZwyXUSuF2msYuGUhbB6+LXMtzR6huKNI12a7pSUigX+0UH4L3RMy1y01ZomibpPPt5vwxp+uOR3qXG2NenuovlOfyh+x9XdbR2ih46u1CtA3NcMyjUfefNkGrYOyM291kV18MlVrquJBV99McgnhOQWjy1Nv5EICSrsBv/CJjSBWnYTbkQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a9ead34-120d-4208-3709-08dafbd18265
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2023 17:04:08.0234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a5uPcR8sj/KULZFuz9SEVkT57fUI4OQ0XuBKFL9SJxiJnuxzfPgsSkEpbzXvb/d77Go3jmjP0YZtIZLq27VpMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6900
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-21_10,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 suspectscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301210164
X-Proofpoint-ORIG-GUID: yQ2hpqKG3VZlHvaYJyn37X8KZlGjenHe
X-Proofpoint-GUID: yQ2hpqKG3VZlHvaYJyn37X8KZlGjenHe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 20, 2023, at 3:54 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Fri, 2023-01-20 at 20:21 +0000, Chuck Lever III wrote:
>>=20
>>> On Jan 20, 2023, at 2:52 PM, Jeff Layton <jlayton@kernel.org> wrote:
>>>=20
>>> nfsd_file_cache_purge is called when the server is shutting down, in
>>> which case, tearing things down is generally fine, but it also gets
>>> called when the exports cache is flushed.
>>=20
>> Yeah... cache flush is probably the case we've been missing.
>>=20
>>=20
>>> Instead of walking the cache and freeing everything unconditionally,
>>> handle it the same as when we have a notification of conflicting access=
.
>>>=20
>>> Fixes: ac3a2585f018 ("nfsd: rework refcounting in filecache")
>>> Reported-by: Ruben Vestergaard <rubenv@drcmr.dk>
>>> Reported-by: Torkil Svensgaard <torkil@drcmr.dk>
>>> Reported-by: Shachar Kagan <skagan@nvidia.com>
>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>> ---
>>> fs/nfsd/filecache.c | 61 +++++++++++++++++++++++++++------------------
>>> 1 file changed, 37 insertions(+), 24 deletions(-)
>>>=20
>>> v2: use the same method to purge entries from the cache as we do when
>>>   there is a notification of conflicting access.
>>>=20
>>> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
>>> index 58ac93e7e680..397ae212b98d 100644
>>> --- a/fs/nfsd/filecache.c
>>> +++ b/fs/nfsd/filecache.c
>>> @@ -661,6 +661,40 @@ static struct shrinker	nfsd_file_shrinker =3D {
>>> 	.seeks =3D 1,
>>> };
>>>=20
>>> +/**
>>> + * maybe_queue_nfsd_file - try to unhash and queue a nfsd_file to be f=
reed
>>> + * @nf: nfsd_file to attempt to queue
>>> + * @dispose: private list to queue successfully-put objects
>>> + *
>>> + * Unhash an nfsd_file, try to get a reference to it, and then put tha=
t
>>> + * reference. If it's the last reference, queue it to the dispose list=
.
>>> + *
>>> + * The caller MUST hold the rcu_read_lock() !
>>=20
>> __nfsd_file_cache_purge() isn't holding rcu_read_lock(), it's
>> holding the nfsd_mutex. Is this comment incorrect, or is it just
>> too specific? Or did I miss something obvious?
>>=20
>=20
> It's implicitly taken by rhashtable_walk_start and released by
> rhashtable_walk_stop.
>=20
> FWIW, it'd be nice if there were a lockdep_assert_held equivalent for
> the rcu_read_lock() here, but I didn't see one of those.

Would

static void
nfsd_file_cond_queue(struct nfsd_file *nf, struct list_head *dispose)  =20
	__must_hold(RCU)
{

do the trick?


> There is a
> rcu_read_lock_held(), but I didn't see a good way to get that to compile
> out when lockdep was disabled.
>=20
>>> + */
>>> +static void
>>> +maybe_queue_nfsd_file(struct nfsd_file *nf, struct list_head *dispose)
>>=20
>> I prefer the name nfsd_file_try_to_queue() or nfsd_file_try_to_dispose()=
.
>> nfsd_file_ should be the prefix where possible. Unless you're
>> redriving, I can fix that.
>>=20
>>=20
>=20
> Rename at will.

Done and applied to nfsd-fixes, replacing v1 of this patch.


>>> +{
>>> +	int decrement =3D 1;
>>> +
>>> +	/* If we raced with someone else unhashing, ignore it */
>>> +	if (!nfsd_file_unhash(nf))
>>> +		return;
>>> +
>>> +	/* If we can't get a reference, ignore it */
>>> +	if (!nfsd_file_get(nf))
>>> +		return;
>>> +
>>> +	/* Extra decrement if we remove from the LRU */
>>> +	if (nfsd_file_lru_remove(nf))
>>> +		++decrement;
>>> +
>>> +	/* If refcount goes to 0, then put on the dispose list */
>>> +	if (refcount_sub_and_test(decrement, &nf->nf_ref)) {
>>> +		list_add(&nf->nf_lru, dispose);
>>> +		trace_nfsd_file_closing(nf);
>>> +	}
>>> +}
>>> +
>>> /**
>>> * nfsd_file_queue_for_close: try to close out any open nfsd_files for a=
n inode
>>> * @inode:   inode on which to close out nfsd_files
>>> @@ -688,30 +722,12 @@ nfsd_file_queue_for_close(struct inode *inode, st=
ruct list_head *dispose)
>>>=20
>>> 	rcu_read_lock();
>>> 	do {
>>> -		int decrement =3D 1;
>>> -
>>> 		nf =3D rhashtable_lookup(&nfsd_file_rhash_tbl, &key,
>>> 				       nfsd_file_rhash_params);
>>> 		if (!nf)
>>> 			break;
>>>=20
>>> -		/* If we raced with someone else unhashing, ignore it */
>>> -		if (!nfsd_file_unhash(nf))
>>> -			continue;
>>> -
>>> -		/* If we can't get a reference, ignore it */
>>> -		if (!nfsd_file_get(nf))
>>> -			continue;
>>> -
>>> -		/* Extra decrement if we remove from the LRU */
>>> -		if (nfsd_file_lru_remove(nf))
>>> -			++decrement;
>>> -
>>> -		/* If refcount goes to 0, then put on the dispose list */
>>> -		if (refcount_sub_and_test(decrement, &nf->nf_ref)) {
>>> -			list_add(&nf->nf_lru, dispose);
>>> -			trace_nfsd_file_closing(nf);
>>> -		}
>>> +		maybe_queue_nfsd_file(nf, dispose);
>>> 	} while (1);
>>> 	rcu_read_unlock();
>>> }
>>> @@ -928,11 +944,8 @@ __nfsd_file_cache_purge(struct net *net)
>>>=20
>>> 		nf =3D rhashtable_walk_next(&iter);
>>> 		while (!IS_ERR_OR_NULL(nf)) {
>>> -			if (!net || nf->nf_net =3D=3D net) {
>>> -				nfsd_file_unhash(nf);
>>> -				nfsd_file_lru_remove(nf);
>>> -				list_add(&nf->nf_lru, &dispose);
>>> -			}
>>> +			if (!net || nf->nf_net =3D=3D net)
>>> +				maybe_queue_nfsd_file(nf, &dispose);
>>> 			nf =3D rhashtable_walk_next(&iter);
>>> 		}
>>>=20
>>> --=20
>>> 2.39.0
>>>=20
>>=20
>> --
>> Chuck Lever
>>=20
>>=20
>>=20
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>

--
Chuck Lever



