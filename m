Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A4570985A
	for <lists+linux-nfs@lfdr.de>; Fri, 19 May 2023 15:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbjESNbr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 19 May 2023 09:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbjESNbn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 19 May 2023 09:31:43 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6F713E
        for <linux-nfs@vger.kernel.org>; Fri, 19 May 2023 06:31:18 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34JCiw7c016891;
        Fri, 19 May 2023 13:31:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=zs/3spxo9rc7oMUyDVoZfVTPGjVRvlPc2YtsubJEqjo=;
 b=S+82QfGSgimVQfzP5mK3n1vwhyPTolO0hwOUY5PNRRB2Q8obmxaTIPXramQesSpSgWEZ
 Y5u6tf9Q2BFsbyMB1E3taOmjbF75v8GhOR5y8xtO8xKqhtGcofTffMoa235hU7fzQDv1
 5nwzktQxM9brE8hA6E1tL1+BxhU/Xj431wPbtGF0Hz5df0YHpfLT8Eq3lvKODfjdRr9F
 sr9vN59vwOtLspMCfkH1zY2yGmkkdhjP8+k0Qwr6zI4r+deeaV0bB5zvqSIlfhzRDH4w
 jEWMUNljuGoUdO09kavGF68PhR2WrOGTdo/Q1UEXVlRHVPyivoJj/WqJ96M/6QmfXmcz NA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj2kdtkfv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 May 2023 13:31:06 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34JCV1cl004173;
        Fri, 19 May 2023 13:31:06 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2046.outbound.protection.outlook.com [104.47.51.46])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj10edcpx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 May 2023 13:31:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZFG2IEDJkLjWVA9Rsw0KzKDiIljNUdoWhof5FRviXJqeOFgZSJbaJab2QYg3E6M2IlPGapc78WoIxsOcT2Dp3BbSN18SYP0ce6gTJ1duUdleRfGDZjy349Eisd22w+wy3kM5fa+XW1NjmQ/lqm2JHc0+8A8YX3jrEMyjIt89WeX0bkD8NcSErhHJQ31eGAfQPzYBFByom5zCFtyOCacBsRZrZL0zfVh6cq8xjykBLlAZ18n2zvqfbJD/qXSd8YbZq72eKRKBYDpPhnaVjuy5Mzr8VDH78z71MloBlwaDaqhjkLlhBFZERTjyoMsYaZxLbfIKK6gLRx+iQAjSq3zGmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zs/3spxo9rc7oMUyDVoZfVTPGjVRvlPc2YtsubJEqjo=;
 b=f1yuv2RHYZwwMjbxChLJTuvIZzqsAkerIrzcMypHIZQq8aEaq8cjnzJ3KJ9x3JPv+VeXrBSv8B2doOOqMkkzVRyip0OK405dBu40v5jYBUJsWk5wbAMbYM1efdZVVVloPSeKJQsNWALq1vAi9DHIctxVmJG23rig7cFuToYpUnookVhQB2AB8Ka/wsv73VkBQiC20t2h9HjRiey8aQXupLKYR1v03qFQiLblBhA00GmvN5WBbaMKryXby5M1SqhNC0E1/bYAUR//gQESDO21IN2BtxDCTIdPNHz3miEyBwyhXi4acvBX/dK7YFQ2JqwLPTTuB/JuZ+008jWblwQzXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zs/3spxo9rc7oMUyDVoZfVTPGjVRvlPc2YtsubJEqjo=;
 b=0PajGUtFejRtgQf+Vxzj8TqbFhHdEH3K8/E2qkKJVY7lWoO7PNLl/Xg0uNUiDnGBPmQLidbwIdFE21sORMEUuVm3H3OJhC6hnBXYZH/5eV8m2KUDHRkwkmJaYryfhs4uYmyTa4M3SFh0cqBEX/WpoUTVzr1qH1/L/Vt7ghrVWGI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB4991.namprd10.prod.outlook.com (2603:10b6:5:38e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 13:31:04 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 13:31:04 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: don't provide pre/post-op attrs if fh_getattr fails
Thread-Topic: [PATCH] nfsd: don't provide pre/post-op attrs if fh_getattr
 fails
Thread-Index: AQHZikOAXGHeeefv3UWBymioFz6Qoq9hkV0AgAAFHQCAAAFDgA==
Date:   Fri, 19 May 2023 13:31:03 +0000
Message-ID: <76A74427-0908-40C6-91F9-0DE429059F7C@oracle.com>
References: <20230519111723.20612-1-jlayton@kernel.org>
 <e0c64e6c69552872925312ca012946acc308b71c.camel@hammerspace.com>
 <84004358376fe8dbd524e71a6d06e83563be717c.camel@kernel.org>
In-Reply-To: <84004358376fe8dbd524e71a6d06e83563be717c.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS7PR10MB4991:EE_
x-ms-office365-filtering-correlation-id: ecd8d7a2-f537-4d26-735a-08db586d4b39
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jJOctNFE9ps6ohbE06XCKsEA8NoV1fwRG18m6RGlD8bwyteTDR6j/aFlWTLucCb82TPc6Q6bjAAgqPOLHPMxFwIgD1lHXjlnk68wISlsQ51uCbWuu+8WyH06ipSoDQJYlmtm3D/Nos4Xm3tyGjZ2CbfjDpGzxHeyDLHeRWueXSCSfo5dpJpavBkU1hxwtKKIIWdLJhR2kYvp5qF+kLG8Uyh6lqJ7GtF0R/mCKT/ug//rT/PM5+OL+eFO/tw9vHI56M3PZpvLs2VvyULjsR2KgKDEPdduLjTzdTYkggrKtz18Q/RIowffpI37imcxqUOCg+/XSDcmlC0BNOrJoPTmj6j8Lpw/1GQRvgNO63mWTjevZNmhDG2Ny/4/qbrWync88LbUdTispPqsF0+39W+MTAXkIS1EGSGf5ljUpl2kqHlswj4NZbMymBMhaoSlTi77BSc/7gUf6S5A4+ITgJdAm4DC344V7UMv4lhI6KfwnXcNq8RlgRbyvi53XoftbhDE7d9N+d+1tD2mrbI1ALWFGfP0DovDmMVLmd+t5HvpKjOpt2x3K2cm1Vdcjztrt2NYOBr3B0WspfXVr/JQOFhnIEgM4BM+afPSsRX6lUp4+khQb138ooDLb/MLDGlqvWKfHpFXnczmc4yOf4AFwIV9Sw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(376002)(136003)(39860400002)(396003)(451199021)(66946007)(66556008)(76116006)(2906002)(64756008)(66476007)(66446008)(91956017)(38070700005)(38100700002)(53546011)(186003)(6512007)(26005)(6506007)(71200400001)(83380400001)(2616005)(122000001)(86362001)(6486002)(33656002)(54906003)(36756003)(478600001)(8936002)(8676002)(41300700001)(4326008)(6916009)(316002)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7R7PDb7NeRK7A6As3Y5g2fSEx7fYJ4cUsPJFb2jTvR0hjg6zXGWnM/9FZzqH?=
 =?us-ascii?Q?9zSzChnDWI8AIgA/fwpYTIsVg5Ni0b/jWlg69b04exHwMo1NUfNoZQHtOxqg?=
 =?us-ascii?Q?zV5S50csOIpwe5LOB/0XqBjCy+Tz3CzjRavpvS/gnQaf9dJOzWeHDG4zYwC/?=
 =?us-ascii?Q?Sh+sHjRw+p3x80qiLMRZuKYyjYyw0cNKpelhT2z1Yp+vmC6PpAGB9Gd4W4KX?=
 =?us-ascii?Q?Sc8RaGLMl6YEPAfj4u6Bo/sAg9lNPYTJtHuQ4qsU3wRmqBfrbezKhJCcgoCV?=
 =?us-ascii?Q?JOc12fj1zzff6r3QqJOo3dLiQbrf9MplUeuQeQ92ulKfFuELjzvtspdd7i17?=
 =?us-ascii?Q?hW4N/VFCuSrjekcbc2nakYNFnB0eYnJN5Caj+sGv/56kVVIRmE3zZ1Hr3GcO?=
 =?us-ascii?Q?p4+iJSma62S7A102unNFjgOfvk8OJKQ9G69U7LHgiLjOMiE4bm7rS/Q5ntpV?=
 =?us-ascii?Q?Fpw3noyr7c92kwLPbhteOvqKAlA0sLofaCkHioXq00xjV+eDajGqBXhc6g9r?=
 =?us-ascii?Q?c72lUWlOgld+SuFgJzZowlWUYAYuWG6I1tK63XTJBEf3sNe+icnY9rrt3VLK?=
 =?us-ascii?Q?LfJdfaKVqIwBbeDcWDuXL7CYwdmKonRdcuL/fFiAP7sqlhS49qexDV5aBfa7?=
 =?us-ascii?Q?vml7i1lSWRPwzLLr1hUc0vh3bu3OCmAP3C9UxYma+d7HzIEw2u1NVj9G1T7h?=
 =?us-ascii?Q?qCvmdF2onZFBGcXBNWQLGBdq+7dDoqv6foXccEachgcgk13W3J/JDsqrj61v?=
 =?us-ascii?Q?64cZQxLUTmajVh6bjWUPHulsZVSCbnb/wLdRj/ljXvDqvry19NCuSHX7sYku?=
 =?us-ascii?Q?JQGss6kCL0tt3iz3ejTU3UrZAaOCPu5yDPFMsvdkbD/Tjc91Oovt4xEEyDC1?=
 =?us-ascii?Q?cY9yuHS4xwNC4GhCgALGP79cDaVYG6jlQoePQt4nwSfZRLuQ/y41WOc8cWKV?=
 =?us-ascii?Q?7gymi4JHvx+a13Irj54Hmwkyx07LxxtaFqrVTamHq079zn92JlV0f8103D3i?=
 =?us-ascii?Q?i8VDKlD/Os1kHYcDr2VS90e7dWjdqEGSi0Dn1Ct8wEsrYIDRZT1D9wz+5vRB?=
 =?us-ascii?Q?o5ZFdDVfutzB5+uqVzIE40mqNA+nnTedG/P+e/KL/ZkgRcLiE3pbPF1g0j5Z?=
 =?us-ascii?Q?uwF2jXNQuYaKRe5vZ5Su1fmk34EIawLjwhBeASNB0c+2sHUO68OIdmCy9oV+?=
 =?us-ascii?Q?714+mI2QnFWpfZjOZgDCi4o+40X4gcF4VNwCZcRaHJ9+I4/vufp9cgsPu+dQ?=
 =?us-ascii?Q?7WSoUJA1qnHpyre43HfV5va98wJQaEODv0S1uxerIYlkm3K3Vq40q7fkDdUF?=
 =?us-ascii?Q?TSU2yGpgmpYM5pX3zaounoFSr57LHkapbk9kYvtdaXA3vQ/+hP68vYvyWGhc?=
 =?us-ascii?Q?nla9fv6zTgAx9wydTAeBO6zzBFJHTFBvVksxkoFag5FIxuGLdjoHsNVqz+LV?=
 =?us-ascii?Q?csd9XflL927OVpT9oesG7rR+BG5CTzxBU96Mhi4fvTlKQympvBJbnRWE4EyI?=
 =?us-ascii?Q?LXPojJHMliJtyeGx/cvpNVUA71djD7SK4oYTlkEwzoSeOq3f7W3a507vc8pY?=
 =?us-ascii?Q?Gh8AsU4wo0RkQ43ndFQ8acmw19e/JBCbzFmdQADde5g058eBoeZ5B8hZDg9O?=
 =?us-ascii?Q?+Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <27867B2786C53342888E793D19D7F972@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0jALYEvWN2FO7IucE49CnVeZw/E9fBW8OkFB1eiGs5Lo/nPO7T+RwBfU0jjdBTcVDeYdJ1AKTmA+jsYwTpwUF0/tM1w3/0J+ZHZlhE+iGu7i7hMdd+GdRCaqUjAmOTS9WWRuk8MFS4zjAHrsZO/O0gk82tyxYya8GkYoLV6BqTQXPdj74uo32UdHCEawbdXztI+UaJZ0WsiJQjoQeC1FvDqKxc6WaDop+IAIjU+/nq8nRn2SuRZCiSOgawImrQW1rLhvPHeEv7/Awu/uQ1LhQgyAM3+aU77JdMYaCdhlb40pvVsQsmgWO804UV63L8qgpEhfiPEMqoIJvJuts6Vx7O5U8qGd65iejZpuBTmLkuwdsfMAbEQfIAsYhc+qsjYHyIulGDITw+0MOzpkIriXaquqJC+VFjvLPWDYSVcGnh2qTD/rXI1epCSJraOyOngi524o1GfHILNy+VUPS58fb423S4qEZ44QPG8LooQ+x37LmOenWHvXv/tMbUUe2cpvswB1L2bVVBuYZAwVTZC4J3IzIh58zeFeHg/Ueam5oKzOhvVN7NGkEa4Sixca60O8TCkGFgvL/69w+minIHaB7pO2aqzu38RvYLab5B0N0bCiHA90ojhORX5vMUseh5gDZCQMoIEeDrleQIcPuw0FRrZht9M1A7m0InIZR3DBsqnyp2K4LDg/8oxpUg19FON/7aLbKUjMAchc84zO86biUgCcNFnqkm09nZJKq3+tTMz4Kqk0yHrS2qfTR2PFUj7QO58qY1gy2/KQOXjEwD2Tw3IaLxa8qIKGYXfJMTCBtgyzfBRPVcj36mpZreaJX5TgVBS0d37csK5XC9h9SpWdIQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecd8d7a2-f537-4d26-735a-08db586d4b39
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2023 13:31:03.9216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uQfdhcCxVa4zgs806uGBEqZdZFkF1L44kt1zGM8ngvgAl0tiy8rOcRxLWrG9URcNSZ9/5Qb5MHn8zm2w2r4BcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4991
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_09,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305190114
X-Proofpoint-GUID: YcnFAY6f045mXmbEfFWAixXMmb0pLGK6
X-Proofpoint-ORIG-GUID: YcnFAY6f045mXmbEfFWAixXMmb0pLGK6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 19, 2023, at 9:26 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Fri, 2023-05-19 at 13:08 +0000, Trond Myklebust wrote:
>> On Fri, 2023-05-19 at 07:17 -0400, Jeff Layton wrote:
>>> nfsd calls fh_getattr to get the latest inode attrs for pre/post-op
>>> info. In the event that fh_getattr fails, it resorts to scraping
>>> cached
>>> values out of the inode directly.
>>>=20
>>> Since these attributes are optional, we can just skip providing them
>>> altogether when this happens.
>>>=20
>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>> ---
>>>  fs/nfsd/nfsfh.c | 26 +++++++-------------------
>>>  1 file changed, 7 insertions(+), 19 deletions(-)
>>>=20
>>> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
>>> index ccd8485fee04..e8e13ae72e3c 100644
>>> --- a/fs/nfsd/nfsfh.c
>>> +++ b/fs/nfsd/nfsfh.c
>>> @@ -623,16 +623,9 @@ void fh_fill_pre_attrs(struct svc_fh *fhp)
>>> =20
>>>         inode =3D d_inode(fhp->fh_dentry);
>>>         err =3D fh_getattr(fhp, &stat);
>>> -       if (err) {
>>> -               /* Grab the times from inode anyway */
>>> -               stat.mtime =3D inode->i_mtime;
>>> -               stat.ctime =3D inode->i_ctime;
>>> -               stat.size  =3D inode->i_size;
>>> -               if (v4 && IS_I_VERSION(inode)) {
>>> -                       stat.change_cookie =3D
>>> inode_query_iversion(inode);
>>> -                       stat.result_mask |=3D STATX_CHANGE_COOKIE;
>>> -               }
>>> -       }
>>> +       if (err)
>>> +               return;
>>> +
>>>         if (v4)
>>>                 fhp->fh_pre_change =3D nfsd4_change_attribute(&stat,
>>> inode);
>>> =20
>>> @@ -660,15 +653,10 @@ void fh_fill_post_attrs(struct svc_fh *fhp)
>>>                 printk("nfsd: inode locked twice during
>>> operation.\n");
>>> =20
>>>         err =3D fh_getattr(fhp, &fhp->fh_post_attr);
>>> -       if (err) {
>>> -               fhp->fh_post_saved =3D false;
>>> -               fhp->fh_post_attr.ctime =3D inode->i_ctime;
>>> -               if (v4 && IS_I_VERSION(inode)) {
>>> -                       fhp->fh_post_attr.change_cookie =3D
>>> inode_query_iversion(inode);
>>> -                       fhp->fh_post_attr.result_mask |=3D
>>> STATX_CHANGE_COOKIE;
>>> -               }
>>> -       } else
>>> -               fhp->fh_post_saved =3D true;
>>> +       if (err)
>>> +               return;
>>> +
>>> +       fhp->fh_post_saved =3D true;
>>>         if (v4)
>>>                 fhp->fh_post_change =3D
>>>                         nfsd4_change_attribute(&fhp->fh_post_attr,
>>> inode);
>>=20
>> Unfortunately, I did recently find a corner case where this behaviour
>> will break the Linux NFSv3 client. In the case where READ sometimes
>> returns post-op attributes, and sometimes not, we can end up triggering
>> the 'out_overflow' in xdr_get_next_encode_buffer(), resulting in an EIO
>> error.
>>=20
>> The problem is ultimately due to the attempt by the client to align the
>> pages to where it expects the READ reply to occur. When the behaviour
>> is unpredictable, then it sometimes ends up allocating too little
>> memory for the attributes, and ends up getting confused.
>>=20
>> This bug does need to be fixed in the client, but just a warning that
>> the above server patch would be capable of triggering it.
>>=20
>=20
> Thanks for the heads up. This is not a critical issue, so I'm OK with
> delaying this change if it's going to cause undue pain in the field. We
> could also consider providing a module option or something in the
> meantime, to give people a workaround if they hit it.
>=20
> OTOH, this should only rarely happen. getattr doesn't often fail unless
> you're exporting something like NFS or Ceph and someone does something
> nefarious on the backend server/cluster.

Right, we expect that the fh_getattr() operation will fail only very
rarely, usually due to a file getting removed or renamed over at the
wrong instant.

If you can provide a fix for the client for v6.5, IMO it would be a
low risk to apply both this patch and your fix at the same time.


--
Chuck Lever


