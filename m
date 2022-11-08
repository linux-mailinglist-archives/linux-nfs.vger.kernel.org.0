Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F891621BB1
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Nov 2022 19:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233978AbiKHSSP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Nov 2022 13:18:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234316AbiKHSSN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Nov 2022 13:18:13 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6131583B
        for <linux-nfs@vger.kernel.org>; Tue,  8 Nov 2022 10:18:00 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A8IFtOt022747;
        Tue, 8 Nov 2022 18:17:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=AbRKgu/FoBxc3zgcQuvuBzOR6gpPvsza/s9OGw5k2lE=;
 b=Ctx9H8HEcfAOJOhcrwuZ+/WP6KqEv7/yGrVo317XTWid9o6RbT+ZWg+21y/0zEoy6i8B
 hW5K9P1IlYng11pnEoOibh1bJzQS/jj0XfmL9N67WA2jQqa16HXzj7rwK0tJGLkWN18M
 GqC0I28CceS6RzP307b+lq2M05JMzoL5KXXD8N+c9EXM+S5IAL9OKNdlyNTyBHfb+31C
 5ObWUvOjuwn5nFepmaWsEEoBz/AxXqXY1+lQFgY+56yN6rRbFm7WL0WXAMxMnd2NjsAI
 yC1mfy57zT06cjI6Lp6kyzUs71sv4AcgjBkMhmzPc0gPj/HLmZKR4lroFXfhFQj8+/1X /A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kqtjng9m7-30
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Nov 2022 18:17:56 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A8GcFsw017840;
        Tue, 8 Nov 2022 16:53:06 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kpctccq1x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Nov 2022 16:53:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BnnIqljHwjDU+N1lINwbn8MzmLe7yOHuZrHkyiOqJMr/Jjs8OwsldKKNIQmSCJNPxrb5JkcsT+dgq8pEgDYozDt7J/3573TpEIb7g7Jq53b92YsHzYrGk/DBl3UPmYT7G7NVF+3ReOSwF6IerJn2V1OWDtpYm7gZkrcvQuOGQF63RuJLrx05RiJtCCiyQDO1PnM5yaC7o/7iTEGQuuEQepTYlVInCMu0VkPUvvmreiQXqcSKvB6tlbWQDWLyFIE/iB4mnmRncbaQAU5ydJdqnv90V/OseRVAND1a9vdyFQ9OSztqtTSE6Bwyqo7IDuDuaNpGAhsBkdOj2zEG4Fmvsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AbRKgu/FoBxc3zgcQuvuBzOR6gpPvsza/s9OGw5k2lE=;
 b=fMhb0DD2cH+gY/4KeCOTCYOkpIcC5IR55Cwoz8yeoBbvweBjA2uXN/OAr2AcTM+LB1aByFmcitOKVGjAN7j7Mqm2Yi9FbcPqRDaz34cMCX++DatCnS8zF5V0LkTM3vpzo8xtb4oB+42l3+Ktfem/EEl3qSwwDcxj7bQFSvIBGLOZlX8bkl7nP7mdqHNMkofBWkm98ZFzsz/NDhSG1L2GrZ1oZgfa/X9KxuhBdtuQKj+lxEZQ/BA5dcX6WBBQfsLMxgDlGLkAzmi582SU5yKh+kHuZPw/TN1/vbVYvMqYMPh1xoudz4Ex7vhTPIg4H3gOYZj/3s6GfPcvmDRTxFy2Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AbRKgu/FoBxc3zgcQuvuBzOR6gpPvsza/s9OGw5k2lE=;
 b=Kfy7A+f4i8ryJOBhRjKVeJlD7sAFYRzd3fFxJ2F1NpmPGHzpDZD/8nXMWuqcmNR11ZVsQvsPy25Rwl8ovBIJxUqAhMCyhsq7s9WIo/ab2lzPv79enYZEzedP/IyZ3pZhgcExDYMmpu3ZqLFS6DCow0a0a9Lbe6eDgLZ+rEjeRcw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB6781.namprd10.prod.outlook.com (2603:10b6:208:42b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Tue, 8 Nov
 2022 16:52:58 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e%4]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 16:52:57 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "trondmy@kernel.org" <trondmy@kernel.org>
Subject: Re: [PATCH] lockd: set other missing fields when unlocking files
Thread-Topic: [PATCH] lockd: set other missing fields when unlocking files
Thread-Index: AQHY8hNC3sPhc+haY0qhdJ9lwSIMWK4zSOCAgAC6TgCAAR2kgIAAHQ+AgAADE4A=
Date:   Tue, 8 Nov 2022 16:52:57 +0000
Message-ID: <020EC0D6-7EEE-4678-B2B7-B9F58D4EDB15@oracle.com>
References: <20221106190239.404803-1-trondmy@kernel.org>
 <2b5cffddf1d4d5791758e267b7184f0263519335.camel@kernel.org>
 <6D002058-C292-4F77-A1B7-C943B3A203C5@oracle.com>
 <B6C6DFDF-3AEC-4BAD-8810-76A47824E282@oracle.com>
 <a77a62bad91ad53fd896ba2a752e0f0cc5ced47f.camel@kernel.org>
In-Reply-To: <a77a62bad91ad53fd896ba2a752e0f0cc5ced47f.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|IA1PR10MB6781:EE_
x-ms-office365-filtering-correlation-id: 87af0efa-6115-444a-e52d-08dac1a9b050
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WNhfOHpNMJ4JCYOK+ZlQCPQoZo3rhLLbJxV/7Ztx5dhMCBTbF37pv4XE0egvQW2r0HwmjLWmAZIGZ53svPRb2l09jNk/QvpHEG+Eaq9S3aAaJkMLVc+eS1PnGv53zzN5ILmvou8DaAIOihrdRSN6PkboIen4vXFPRKHr9PvtYX2s0HzS/ytkrMiNSM+DW9+LvjyTsmFxyP254fxEtkp3qGA7McqfuJYwN9oQc8BJmgQkysxg94CXpdB3g2Tw6G+2eTm4M3raLn4QyadS3NGozC9IY+BqH+5L8RHHBJtd7xtIolOr2qjSPTw/vpL2bkxpCjt/a32bXaFVD2IMHVnsOVwHLHLPoaprsmap3K4GRJ9xGLeby1OKSH5I+Pb7LBCGP0dqNg8ilgy2wkvFrSXEYTjY51uUOrBHEKm7XiKTYAt+K0hjzgJXbNXZPoP8LhPyOu3T8Ki6ZxTWzj0jMAEWMnLu3R2v4VOMrSygI1LiKZRKPXSzto4hQzMRMNO85ep7f5D8O8Qt+JUOHkc6jeFzliZ5AZTLsRhP+HY3aIfQb9AkfwDxJcEFN3Tt0wb68dVTKLF/kNTw+X5rRj+iHm1TJoewllThc+o+B/P22tZB6Zd81+odSYE+R4oEFA1mvXmyj2BTrh0PrNhatD6o5uqpGqiaZoyuo23ancCnty/x0h7gZ3EQ9KL+FUKWd5Efxj/wS8UF6e69fVkhbqYdDl7vwPV/H0Y38uG+Zm6wq5P+Iqy12M896nu7rS3ZCFy8+ViJitQ+sVCI46keTJ+VcTfgSDLqUbOhO/MKxRHvTVBML0o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(39860400002)(376002)(366004)(136003)(451199015)(122000001)(83380400001)(33656002)(86362001)(38100700002)(38070700005)(478600001)(5660300002)(71200400001)(6486002)(4326008)(64756008)(8676002)(76116006)(66556008)(66476007)(66946007)(66446008)(41300700001)(91956017)(316002)(54906003)(6916009)(2616005)(186003)(6512007)(6506007)(2906002)(8936002)(26005)(53546011)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hv8Kihw1hOt51a9sQAIxo2Z5L02YkvwdQxGjr+LIhCjlzliwEIpREe0ytv5R?=
 =?us-ascii?Q?Af0oobjleAqw9siqBvgwRaF+8pVXp2oFRC4UDszkSUyX1wFrNPZJrxGkbhQk?=
 =?us-ascii?Q?Zvl6SyRHmtwBF4ryYcw+K3c71yk4cyEte2fP7Reu4wRyg18HquPioNBsNOGR?=
 =?us-ascii?Q?XtcY01+QMUh2AJlE71YzTBJeJ86ExLaltwUNAQK5e8pbe4aV5S8EJ2Yk/x4a?=
 =?us-ascii?Q?cBI/Lu1IMuN07enaNt9BgZvB8FfnBuJMkfEfUXvC45L6abg4XMtr9xL33P0U?=
 =?us-ascii?Q?AeB2ZG15wBFkQDlxZPeyhBmimYc4j1gON5ZTgImRBkG0LRnXfk8utU7uru3i?=
 =?us-ascii?Q?wVrvIEzXP8unurraPhxN69BHG4QNzkOB7IL6bElBxrT8souKLkIM+qjmYydR?=
 =?us-ascii?Q?eKQIDgo9J0623qS7rBaghppMMtznTYLzsl1Bcb1divFjTKIq1AgbYm0cC6MI?=
 =?us-ascii?Q?pBQPmHe+e7yTXuI+itR2Hb0t5IVmqmwwnrLbpfxevFJwrTXBCS4O6ZpDTKWt?=
 =?us-ascii?Q?MXC4XDxOqhPYK1UQNcvAlwoWIq0HHNvhigD0zu/TD2b4ErYwyx7GL5cJ+XTs?=
 =?us-ascii?Q?2If/J+ipPOqyPuazzIRnT6EfedfKDYSXmM3Mxh43OWq5Z1sD/COMRxvsEd4P?=
 =?us-ascii?Q?egQSJjlsPiljqgsJUvHzJpa77D63pLJco5AYEIxSj3ranteFZgBvHK0Fnh5r?=
 =?us-ascii?Q?b3OmDoVM+0xcIiV4jMRPlFV3ZRY5L9OwehYCHTE19Z2KSon88v4SaKpYu4kO?=
 =?us-ascii?Q?m9F+dcUIZzqqsWastMyHT8POmvQ2HVa9oRGdbT05wSzLh0o5pGrmgIWkonOI?=
 =?us-ascii?Q?OXpHQCnifts/a7PD3Ac96+/MuiXK83J/DKRAWBdPPmtlYS5722Q05tZIo95i?=
 =?us-ascii?Q?CG4fT/ys5jsXHnvyuepp54szs+yt3xhLeqKjxOyr7cw8TVPhysFlaJ/DiK/3?=
 =?us-ascii?Q?q4bWc7XUZys1GCU/tQKb7psIBw3UrVylCzgtsg50bib1yG3AUX+n0BqMzJJE?=
 =?us-ascii?Q?Q8ql9EgWtJw9i/p7BLN+b0ZwGCjewD9/RVI5RCqZWbmLYG+Lp4lLD7vrAHLH?=
 =?us-ascii?Q?d/Em+LX8HNspUT186KbQNAf7ZUcfPcB1Qsyb6TRZqE7yZdE9cQrFmwut8nNu?=
 =?us-ascii?Q?xNt7a2rm8cZCO1f94w7BH03W3c4KiFjCXh6UraZ80QOfE/o1dyJdscJu5358?=
 =?us-ascii?Q?+svwXvqXpoCCgdDLmtVU+iH8NE93t/ZTddDaRC/wVd7mu/Pi1Gjwv3KJr52l?=
 =?us-ascii?Q?ileIeqJcuR0xjJYQfynIooyExkJSH0QA6r0eSRyl1EllwS71SZYkJ+AfP6mq?=
 =?us-ascii?Q?ORJzpvKMl4lV5TPjrSac0WZ2giN8F1T9fGf+vdNePNbH4OgbAzn7k7bUeJSa?=
 =?us-ascii?Q?Hi5KzxszG92e7FYDdFGajs0R/moV3KWxpHVWv7PDKC8X90TLNdi8U6/K6X/T?=
 =?us-ascii?Q?Lxqb0TFWB7SZVtJ7nKUb5CYYn5R/Jifetd3/4AjKUv+WELUcEXoEBntbauws?=
 =?us-ascii?Q?kXctOdO19Xoip0UnOO/8d2YYi5tL3VvSEcbSOU/RXCP4uy+Cbgr1ZLFgoxQp?=
 =?us-ascii?Q?kMoKJF/NjMy6jVry0nCYqsMQ5uxIqVWOum4WfFmDs54WI4pSw6FDs2XClrNU?=
 =?us-ascii?Q?sg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9A0B3A8619A1C042AD2E69BD03A4FCE1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87af0efa-6115-444a-e52d-08dac1a9b050
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2022 16:52:57.7446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xoUIsfmAt8An7gzOcP6bfjmeF3JW7dXZhKgDq/YcxwdXDh4+wrqMe54B9BP5Co7o4ErmaYrcbYnzGGFgI6ts/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6781
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211080105
X-Proofpoint-ORIG-GUID: tmfjzlZP5ZWRqdBkLI0ISBCfaI3aNIxH
X-Proofpoint-GUID: tmfjzlZP5ZWRqdBkLI0ISBCfaI3aNIxH
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 8, 2022, at 11:41 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Tue, 2022-11-08 at 14:57 +0000, Chuck Lever III wrote:
>>=20
>>> On Nov 7, 2022, at 4:55 PM, Chuck Lever III <chuck.lever@oracle.com> wr=
ote:
>>>=20
>>>> On Nov 7, 2022, at 5:48 AM, Jeff Layton <jlayton@kernel.org> wrote:
>>>>=20
>>>> On Sun, 2022-11-06 at 14:02 -0500, trondmy@kernel.org wrote:
>>>>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>>>>>=20
>>>>> vfs_lock_file() expects the struct file_lock to be fully initialised =
by
>>>>> the caller.
>>>=20
>>> As a reviewer, I don't see anything in the vfs_lock_file() kdoc
>>> comment that suggests this, and vfs_lock_file() itself is just
>>> a wrapper around each filesystem's f_ops->lock method. That
>>> expectation is a bit deeper into NFS-specific code. A few more
>>> observations below.
>>>=20
>>>=20
>>>>> Re-exported NFSv3 has been seen to Oops if the fl_file field
>>>>> is NULL.
>>>=20
>>> Needs a Link: to the bug report. Which I can add.
>>>=20
>>> This will also give us a call trace we can reference, so I won't
>>> add that here.
>>>=20
>>>=20
>>>>> Fixes: aec158242b87 ("lockd: set fl_owner when unlocking files")
>>>>> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
>>>>> ---
>>>>> fs/lockd/svcsubs.c | 17 ++++++++++-------
>>>>> 1 file changed, 10 insertions(+), 7 deletions(-)
>>>>>=20
>>>>> diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
>>>>> index e1c4617de771..3515f17eaf3f 100644
>>>>> --- a/fs/lockd/svcsubs.c
>>>>> +++ b/fs/lockd/svcsubs.c
>>>>> @@ -176,7 +176,7 @@ nlm_delete_file(struct nlm_file *file)
>>>>> 	}
>>>>> }
>>>>>=20
>>>>> -static int nlm_unlock_files(struct nlm_file *file, fl_owner_t owner)
>>>>> +static int nlm_unlock_files(struct nlm_file *file, const struct file=
_lock *fl)
>>>>> {
>>>>> 	struct file_lock lock;
>>>>>=20
>>>>> @@ -184,12 +184,15 @@ static int nlm_unlock_files(struct nlm_file *fi=
le, fl_owner_t owner)
>>>>> 	lock.fl_type  =3D F_UNLCK;
>>>>> 	lock.fl_start =3D 0;
>>>>> 	lock.fl_end   =3D OFFSET_MAX;
>>>>> -	lock.fl_owner =3D owner;
>>>>> -	if (file->f_file[O_RDONLY] &&
>>>>> -	    vfs_lock_file(file->f_file[O_RDONLY], F_SETLK, &lock, NULL))
>>>>> +	lock.fl_owner =3D fl->fl_owner;
>>>>> +	lock.fl_pid   =3D fl->fl_pid;
>>>>> +	lock.fl_flags =3D FL_POSIX;
>>>>> +
>>>>> +	lock.fl_file =3D file->f_file[O_RDONLY];
>>>>> +	if (lock.fl_file && vfs_lock_file(lock.fl_file, F_SETLK, &lock, NUL=
L))
>>>>> 		goto out_err;
>>>>> -	if (file->f_file[O_WRONLY] &&
>>>>> -	    vfs_lock_file(file->f_file[O_WRONLY], F_SETLK, &lock, NULL))
>>>>> +	lock.fl_file =3D file->f_file[O_WRONLY];
>>>>> +	if (lock.fl_file && vfs_lock_file(lock.fl_file, F_SETLK, &lock, NUL=
L))
>>>>> 		goto out_err;
>>>>> 	return 0;
>>>>> out_err:
>>>>> @@ -226,7 +229,7 @@ nlm_traverse_locks(struct nlm_host *host, struct =
nlm_file *file,
>>>>> 		if (match(lockhost, host)) {
>>>>>=20
>>>>> 			spin_unlock(&flctx->flc_lock);
>>>>> -			if (nlm_unlock_files(file, fl->fl_owner))
>>>>> +			if (nlm_unlock_files(file, fl))
>>>>> 				return 1;
>>>>> 			goto again;
>>>>> 		}
>>>>=20
>>>> Good catch.
>>>>=20
>>>> I wonder if we ought to roll an initializer function for file_locks to
>>>> make it harder for callers to miss setting some fields like this? One
>>>> idea: we could change vfs_lock_file to *not* take a file argument, and
>>>> insist that the caller fill out fl_file when calling it? That would ma=
ke
>>>> it harder to screw this up.
>>>=20
>>> Commit history shows that, at least as far back as the beginning of
>>> the git era, the vfs_lock_file() call site here did not initialize
>>> the fl_file field. So, this code has been working without fully
>>> initializing @fl for, like, forever.
>>>=20
>>>=20
>>> Trond later says:
>>>> The regression occurs in 5.16, because that was when Bruce merged his
>>>> patches to enable locking when doing NFS re-exporting.
>>>=20
>>> That means the Fixes: tag above is misleading. The proposed patch
>>> doesn't actually fix that commit (which went into v5.19), it simply
>>> applies on that commit.
>>>=20
>>> I haven't been able to find the locking patches mentioned here. I think
>>> those bear mentioning (by commit ID) in the patch description, at least=
.
>>> If you know the commit ID, Trond, can you pass it along?
>>>=20
>>> Though I would say that, in agreement with Jeff, the true cause of this
>>> issue is the awkward synopsis for vfs_lock_file().
>>=20
>> Since Trond has re-assigned the kernel.org bug to me... I'll blather on
>> a bit more. (Yesterday's patch is still queued up, I can replace it or
>> move it depending on the outcome of this discussion).
>>=20
>> -> The vfs_{test,lock,cancel}_file APIs all take a file argument. Maybe
>> we shouldn't remove the @filp argument from vfs_lock_file().
>>=20
>=20
> They all take a file_lock argument as well. @filp is redundant in all of
> them. Keeping both just increases the ambiguity. I move that we drop the
> explicit argument since we need to set it in the struct anyway.

Sounds good to me.


> We could also consider adding a @filp arguments to locks_alloc_lock and
> locks_init_lock, to make it a bit more evident that it needs to be set.
>=20
>> -> The struct file_lock * argument of vfs_lock_file() is not a const.
>>=20
>=20
> That might be tough. Even for "request" fl's we modify some fields in
> them (for example, fl_wait and fl_blocked_member). fl_file should never
> change though, once it has been assigned. We could potentially make that
> const.
>=20
>> After auditing the call sites, I think it would be safe for vfs_lock_fil=
e()
>> to explicitly overwrite the fl->fl_file field with the value of the @fil=
p
>> argument before calling f_ops->lock. At the very least, it should sanity=
-
>> check that the two pointer values are the same, and document that as an
>> API requirement.
>>=20
>> Alternatively we could cook up an NFS-specific fix... but the vfs_lock_f=
ile
>> API would still look dodgy.
>>=20
>=20
> I see no reason to do anything NFS-specific here. I'd be fine with
> WARN_ONs in locks.c for now, until we decide what to do longer term.
> It's possible we have some other call chains that are not setting that
> field correctly.

Agreed, a WARN_ON would be a good first step.


> If we can audit all of the call sites and ensure that they are properly
> setting fl_file in the struct, we should be able to painlessly drop the
> separate @filp argument from all of those functions.

The only one I found that doesn't set fl_file close to the vfs_lock_file
call site is do_lock_file_wait().


> I'll toss it onto my to-do pile.

I'm assuming you mean you'll do the API clean-up, and that I should
keep Trond's fix in the nfsd queue.

--
Chuck Lever



