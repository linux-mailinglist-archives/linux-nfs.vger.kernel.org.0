Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C59D3E7E17
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Aug 2021 19:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbhHJRSK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Aug 2021 13:18:10 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:5146 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232717AbhHJRSH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Aug 2021 13:18:07 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17AHGuLf019405;
        Tue, 10 Aug 2021 17:17:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=SU3OaFMmzByDolKEMg7n0QuylGkyuUnIs6AEi7r8Cjg=;
 b=U7WnQqFscHjgze1SNE/Y6XhX2EZJFjAUOxiRFMiawt/VM1dXWOxCJNqP1Ulm2zfEi/N8
 mLub/16j4mxqC/Zl7/KkSrEEULOvBpKET7DF38Q160L/4OJNjnfigMhNRW6qTBNcKQJS
 +xSFpOOJ798vaiKUoQ/SRFlOkAZLHb/6FJwxhVI7uedL+PpXxSccKOkY1jicIs5bSPsx
 MXgZ1UoqUb8ysf8nfZ9RGrp4YfKDRW8e6JwxXrkqipToGDLxVPf9kkXuEOo4G+Rz5Rps
 JTyEfUrxTKDXFFd4/e8xrslfb14dl/qnauVvf+nte2GKp/uN6NAoUzsQu9/WlPajI9nF FQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=SU3OaFMmzByDolKEMg7n0QuylGkyuUnIs6AEi7r8Cjg=;
 b=mN8v+99jqq7agVdYp/YHT5rXQqYbzJn34p/+dSykmw2KHMYp4kZQBVcGXtqRVIteFgRv
 +Iy9cKOXKa4Sy1ou8dZwoHETtLiITyZlKk2vgT9EHM1vyTwZn62pw9CmFMQ+GCtFjaom
 T05MdjY4fxs54HgxLuTWzi187hA7guwKddGxl2prwq+7s2+hmIHSY/xqOKxUakcIfnhT
 ceCqZcSEWoscoLrqUtLB/ZVyiIvrpu2OwdpKFFl8kHk0pwZ46pytyfnRI36iv+Q9m99U
 EiUPjw8iSrWSfUU8jO7kebMBS/+yltA/Xx/kuY34wsUYsCEnEzwFgAZQjr2FHpcjWjuh Ow== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ab01rc7fu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Aug 2021 17:17:41 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17AHGAnb071772;
        Tue, 10 Aug 2021 17:17:40 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by userp3020.oracle.com with ESMTP id 3aa3xtfgmr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Aug 2021 17:17:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=an13KKCW9gjDtqdewhDPNVMnb3Wvs/KyGU3dYdEi/To7n6oLzKhqB6uStjuBNLOXUeG0pCM6aybf5HUUrZDDO3cr6d+gNNFL64zjPkYnubGUDofhD2vLYjSoyFinmcmfJAMJqb/YFk+1KuxD07R3gr26eLfwDQhob7QIUPNKBm5Om8tonHB5tm/omN3ryp708EgsGOMgRdyMv4A4jfSPm3tkmoqLy6JpyNUo9QbmID9dQBCBRGGlICECscS1z8SmZThDJoR9a2JvKZQzBx9Q+jCehtuMCggDfq/HDzRxjdc7hbj2/CK9AQqGn3e3SD1XxOdHCUKV3SbmTTS86cBKlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SU3OaFMmzByDolKEMg7n0QuylGkyuUnIs6AEi7r8Cjg=;
 b=azJBBMc7QXj0AQjGvp05+Hgb+Q/yjg0/TZ3/VnDYPZq3f92Z6uNpFoiY8bpxJx4HniQdyH6HIMUbkvXkVW87UjL2IhkCDex3r2r4n2KqRRlSGqMxKBAwOo6GT4gBq2fIbvHaC6/K9iRDQs9CVDy3ksdL5XDnJQFjDRJOVXBzR+Pkvw/SiPuaw9C+88S7qq2KoKsZKRTOIjBB1K8Sw2Y2FjnaRlFq2mRmUsrYVCfQlBdNKSFRfZ9KY52Uk/aVZnVxW+O9KIt76j0fjdWsTspVUJNRZ1/9VEnb+r40lH2et7HahNrTUbDYLIYE6yEGLMvrcE+r+7fF4MjDGE/uu72MWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SU3OaFMmzByDolKEMg7n0QuylGkyuUnIs6AEi7r8Cjg=;
 b=TSpHpqxlg/ckZZen8Kjby+u6p1MSIWLhMJM2qOKdhZEC1xhgkIXE64Df11jz3UyD6fnc6Wk8GXP2OzpmEzKBa2hy7b9EJ9Lzem8UIOOw6fc8I6OyzyiLem+rY0/ILXhT9OiDUl59A6mfGnvD1x/gvZtQLYD/b+UkmeWzBFpnjlM=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB4212.namprd10.prod.outlook.com (2603:10b6:a03:200::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Tue, 10 Aug
 2021 17:17:38 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::a8db:4fc8:ded5:e64]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::a8db:4fc8:ded5:e64%5]) with mapi id 15.20.4394.023; Tue, 10 Aug 2021
 17:17:38 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Timo Rothenpieler <timo@rothenpieler.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: Spurious instability with NFSoRDMA under moderate load
Thread-Topic: Spurious instability with NFSoRDMA under moderate load
Thread-Index: AQHXSnp8j8N6G2OhyUK9Nr2RtJxnoarn3hgAgAATb4CANuhZgIBOXZcAgAAVhICAADVLgA==
Date:   Tue, 10 Aug 2021 17:17:38 +0000
Message-ID: <4BA2A532-9063-4893-AF53-E1DAB06095CC@oracle.com>
References: <4da3b074-a6be-d83f-ccd4-b151557066aa@rothenpieler.org>
 <72ECF9E1-1F6E-44AF-850C-536BED898DDD@oracle.com>
 <e12c24fd-beaf-31ce-cb49-36ad32bd22b3@rothenpieler.org>
 <daae674a-84d4-de36-336d-693dc582e3ef@rothenpieler.org>
 <9355de20-921c-69e0-e5a4-733b64e125e1@rothenpieler.org>
 <a28b403e-42cf-3189-a4db-86d20da1b7aa@rothenpieler.org>
In-Reply-To: <a28b403e-42cf-3189-a4db-86d20da1b7aa@rothenpieler.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: rothenpieler.org; dkim=none (message not signed)
 header.d=none;rothenpieler.org; dmarc=none action=none
 header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 696bbe9c-6c87-4d7e-3b05-08d95c22c0cb
x-ms-traffictypediagnostic: BY5PR10MB4212:
x-microsoft-antispam-prvs: <BY5PR10MB4212587708ADB41D5CEBE84793F79@BY5PR10MB4212.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nTQeDB9VISASXz8/KeYUMq3eyHpTohP75lJB3luFuG+xj8EFmypTpawR7Tt5+Jyk1rNLmMuNU9ChzCVchvFnlej1hyr4+1iUztVKqe+RmK6K6LESJknC9yZcK9+5G32gMM5Bvf6AvCNI6MWo6+1DFi+8cgMoi79NFoVL7teZh5MbmCdx/cmYizbDoCYKpmqbxQNdduOU73mTF7C1DVriEEP4XO7KfsNlHiX3yPOR2Io9eNJ/DM073HyR32TzRc/GGRUnBIJQIIRw6PfEU0+wZ0ewyRIAmTskYoxQEBemrOSCsHqClyBj/SpTzdMd2owVViVlrEsYAKDgCo1bmEUWJT2IBGD5b64xwJ1bEiPu/GeAj+dV1RaJfQ+xEUHZacakXV1Nj4MkjRzd5wddzzBlxoG2NLHqnUgSNUdIAyEpBObpwHuJdWekA9PPdpZp/CxT4sFQJ0XFdy0o0Q4gcsXIdJIS+vgnfTeGecAfCrrCte7dKRss3xmMSZz91BjPtb5l+HW9zGtrv8IOZQu2jYuu+6X8qTZ94s89Emg3TrNLauDl7wyeFCNWnrxzLRgwFYZJjjf7qObkkO2skiSDZOYQq48HUXP8ZRsAJD6fDCCZgz7ILy44jn1tFXUGdKXY+0WkGF0j1kpDxgHjRPDcOr+r2TEM7l2JTcoxI1eUmXCqqG4QGxHScMQfl5ztgVhPJq5C0uYAu5aaNJ39j3PDeFMyqhQQQ6DtQtjzionZclH3y+gAS/7iEvVkVYTQ5gv+ZAM1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(396003)(136003)(366004)(39860400002)(478600001)(316002)(54906003)(8936002)(53546011)(4326008)(6506007)(6512007)(6486002)(71200400001)(33656002)(5660300002)(8676002)(6916009)(2906002)(83380400001)(66446008)(186003)(64756008)(66556008)(66476007)(66946007)(91956017)(76116006)(26005)(2616005)(38100700002)(122000001)(36756003)(86362001)(38070700005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GmTZTH+DejPs4RDOe7QWQljSObydHEipzoDO/nXo1HMnMwADTWdc3OGWHGrp?=
 =?us-ascii?Q?lHP/u8glDJ9Q/XAci4ueAGY/nQ9OTP6Joi1O3uyvZo+QAVZMayGZJ5dha/J0?=
 =?us-ascii?Q?qz5zCYMITYSOBOfb/xmkjRGFpRwl7Uwh1+6zU9xBaXjH/lrZRJeW4im3EWEW?=
 =?us-ascii?Q?Yk0woQGXAeUx0XS7TbGVTOP0DmVkyBNVer9E9XWB/PZjEy+wb5yTxO0DEPWf?=
 =?us-ascii?Q?CUQ+aG1fb+yyKvvFXMIlCdoEpTNKbIDhKoWkmoq04eZv3ee5caDKhaASYPhs?=
 =?us-ascii?Q?3cJBqNRiPuJBJGFnvhLpRf5YVQhZKbPWxajUSeofs6OWol3lZNcBO1OEcWN2?=
 =?us-ascii?Q?E+KzPuXJezhQwhi4GKdHbrqVIdZfEtW1LSlk5hjDXgamH4n6XVgM02TAuGN8?=
 =?us-ascii?Q?c3QrHs3W+6iEQ+/dwBbzLn19dk+c2J+IuKCg9SCKJEc49Jog2s2yk68Mp/mo?=
 =?us-ascii?Q?GeeF7Yr9rfgjaOu0BJtn60nc/HdPCHJpEMLRZXUKEeWSQYbuEBvUzKk26k44?=
 =?us-ascii?Q?ZJvAxDyXQ5ueqx3GbpkLUvHcPwlBykI0jirkMyTDKTj8cml9697vtwriAjEI?=
 =?us-ascii?Q?3deSq8T16kJDBzJ2gFf3gDdcOfSQf8je+fJpX21nbdMRYZNMTUsBG2aI+k4s?=
 =?us-ascii?Q?oXwZSrs8mywcRXi8iFgfs5cuzFRbvpG8s3NLDFYS7lzRvVLYG/9TmcKUrcnx?=
 =?us-ascii?Q?MwwZ5Q19oGriL0gqsKRN1lGDiBLeCxVTmi0Bw0I303vQHN3XNN0bY3xvQtv1?=
 =?us-ascii?Q?vJ//JMnuckVA497MU45jv+0XoXyHT03wiP2ulQJa2FGrBh1UY/hHZmRKOOyp?=
 =?us-ascii?Q?YobZ7E3PKV0v6/iaCo1A52McFCOgVeuAfN4i9O4PhinxZWo01w4HIT/b96iA?=
 =?us-ascii?Q?HqTZxAhozi2fLHio6hZJtvE72D8JfxG1ZdFtqL46avqlSYHIgzkSYoiF8fzj?=
 =?us-ascii?Q?tJxLh8+AXgyPa2WaNIV73bQ0yqK2taREblRJNPonoT9tkB7Q+X/wexipC8I/?=
 =?us-ascii?Q?RDgxTq1ku5wuXoRAUSCIioAOZOT/Zz6nHwJ1ZZLpAsrl6cLGHu2EzYQSf5xl?=
 =?us-ascii?Q?L9T64lT3vbW1Z7+0ezP2n4x491RmXi3juzBnQoTPDq5AmWnIZN22SDiZ87xD?=
 =?us-ascii?Q?WAr4KyE/jR/N5qF/qeuSCPK1Mih0ogomDddZQ66mmQkQL1TyiVJVp9613qlz?=
 =?us-ascii?Q?m8TSKr9QipzuXvxn35ZaFEdHE0Mk7I/Mp2wZQbWMD6cJgr+OuLFWd5DoPRfs?=
 =?us-ascii?Q?OkKvBssMVEv5EpIHP5t7aylDsgYpzSlaJR9vNAPkxe42CEy2Kvy+7FYfUVC3?=
 =?us-ascii?Q?46VJy6GmnqJqhsF9ehYuhC6+z2B8uaHhoI7UOzqOAIjUqw=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <26C42073A9ACD14CAE6B76BD15EADD2B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 696bbe9c-6c87-4d7e-3b05-08d95c22c0cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2021 17:17:38.1658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u5G35oRBP5rQPSSzEAvMHx6O804CDzzOQhTmyOEVLdaG9QSIObtlHHB4P9h5CcPZjzFyo9IZbMRcuGchRaMAUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4212
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10072 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108100112
X-Proofpoint-ORIG-GUID: Cv2li_9tJ-356Wu3Axbnj_LybP3pr7wm
X-Proofpoint-GUID: Cv2li_9tJ-356Wu3Axbnj_LybP3pr7wm
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 10, 2021, at 10:06 AM, Timo Rothenpieler <timo@rothenpieler.org> w=
rote:
>=20
> On 10.08.2021 14:49, Timo Rothenpieler wrote:
>> Ok, so this just happened again for the first time since upgrading to 5.=
12.
>> Exact same thing, except this time no error cqe was dumped simultaneousl=
y (It still appeared in dmesg, but over a week before the issue showed up).=
 So I'll assume it's unrelated to this issue.
>> I had no issues while running 5.12.12 and below. Recently (14 days ago o=
r so) updated to 5.12.19, and now it's happening again.
>> Unfortunately, with how rarely this issue happens, this can either be a =
regression between those two versions, or it was still present all along an=
d just never triggered for several months.
>> Makes me wonder if this is somehow related to the problem described in "=
NFS server regression in kernel 5.13 (tested w/ 5.13.9)". But the pattern o=
f the issue does not look all that similar, given that for me, the hangs ne=
ver recover, and I have RDMA in the mix.
>=20
> Here's some trace and debug data I collected while it was in a state wher=
e everything using copy_range would get stuck.
> The file(s) in question is named "tmp-copy-*", with a bunch of numbers at=
 the end.
>=20
> This also seems to be entirely a client side issue, since other NFS clien=
ts on the same server work just fine the whole time, and a reboot of that o=
ne affected client makes it work normally again, without touching the serve=
r.
>=20
> In this instance right now, I was even unable to cleanly reboot the clien=
t machine, since it got completely stuck, seemingly unable to unmount the N=
FS shares, getting stuck the same way other operations would.
>=20
> What confuses me the most is that while it is in this messed up state, it=
 generally still works fine, and it's only a few very specific operations (=
only one I know of for sure is copy_range) get stuck.
> The processes also aren't unkillable. a SIGTERM or SIGKILL will end them,=
 and also flushes NFS. Captured that in the dmesg_output2.

What I see in this data is that the server is reporting

   SEQ4_STATUS_CB_PATH_DOWN

and the client is attempting to recover (repeatedly) using
BIND_CONN_TO_SESSION. But apparently the recovery didn't
actually work, because the server continues to report a
callback path problem.

[1712389.125641] nfs41_handle_sequence_flag_errors: "10.110.10.200" (client=
 ID 6765f8600a675814) flags=3D0x00000001
[1712389.129264] nfs4_bind_conn_to_session: bind_conn_to_session was succes=
sful for server 10.110.10.200!

[1712389.171953] nfs41_handle_sequence_flag_errors: "10.110.10.200" (client=
 ID 6765f8600a675814) flags=3D0x00000001
[1712389.178361] nfs4_bind_conn_to_session: bind_conn_to_session was succes=
sful for server 10.110.10.200!

[1712389.195606] nfs41_handle_sequence_flag_errors: "10.110.10.200" (client=
 ID 6765f8600a675814) flags=3D0x00000001
[1712389.203891] nfs4_bind_conn_to_session: bind_conn_to_session was succes=
sful for server 10.110.10.200!

I guess it's time to switch to tracing on the server side
to see if you can nail down why the server's callback
requests are failing. On your NFS server, run:

 # trace-cmd record -e nfsd -e sunrpc -e rpcgss -e rpcrdma

at roughly the same point during your test that you captured
the previous client-side trace.

--
Chuck Lever



