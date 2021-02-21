Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0EFC320C23
	for <lists+linux-nfs@lfdr.de>; Sun, 21 Feb 2021 18:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbhBURqH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 21 Feb 2021 12:46:07 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:51572 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbhBURqF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 21 Feb 2021 12:46:05 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11LHjCi6126283;
        Sun, 21 Feb 2021 17:45:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=luWTWLdEtObbNIm04ouGXx0/VeG/IIpM1tRllzw6JZw=;
 b=Kuhz5Ym339NgQcRs4GAjJ4yLp1LXua/fbkRbsr8kctFTEAImThwRSPK/XwgrE4TRU2V6
 z0nzi3Ph7v7YT9mYyT3F2DAEwR5i35MrDIGGagp4YsC3kL9w7AocGnr6CGNKnRA4QzuM
 CepwteC6HBsm1HGrIYn8Pfknq/KPvLl2mpYFDyzbmqYurNJaAplpoRQMvao5Xm+t+CEX
 jteg063uIFFFZfKdMdImWljWUecIj/Vsfd/9QSVrRbHV5LirHdSVml7o0ROeQVoKFvhx
 t4bdkC5V/3lxvCn4vD8CcjAjFHGUQCNsL3fl5EdYXJAaFPzDCQCww8+HObW6/05VYj4P jg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 36tqxb9wbn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 21 Feb 2021 17:45:11 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11LHaQcX044058;
        Sun, 21 Feb 2021 17:45:11 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by aserp3020.oracle.com with ESMTP id 36ucaw8n14-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 21 Feb 2021 17:45:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=np8Dqp6uVIhNTFP0O6o/E0JurXung4ioPsklhStlu4YxsXWW8mrkKgHFRjdzol7gVTHDi9CKmfAZ1+y0+lhdGl3RjtkNkEeXMk/Ppd7Un7gPpbZ/oPM8IvMtz0IiJFlCrMqy5GipHxW7bwis45+WfgukzVvII9bwKQVMvvRry+OnNgCSG4W0E/9/BjtDRQ8Xb3gGw2Bo4MaOw87rwjwcfFQMMmx8hoTidL51DJOtVGZkG67ZJke+zmmOfDNh4NEJuYLUMrCnVwaZ2aavPoKrc7tqPXOhT7XxJ0wxQHjtnlnugQntmwaGIO83Q1kQEo4D8+K1hUOUpIgpcVnsJpPcgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=luWTWLdEtObbNIm04ouGXx0/VeG/IIpM1tRllzw6JZw=;
 b=bbshshMvhhd918kyuGmptJ1uOl90XEM4DbMx0XOijM8goOX5h2fBoooktGObNxXhZ8QVxjyN5Xn0k20Zta9Kxd790PGj1T9yDo7K0fAuhmVqkgsfASgVo50qLgWUOxbSdNQsXughI9EG4llrTxyISA6fdwY5lkiqqAbFgTWg1eMLPXbhOLwUshXFAIM048aJsRIHk9PtatDf3TjjAQYVo8xWxSffkHvvQ2PcUyc9J6INKsw7LDo9jtK0nlxhr8ixe7CP7lBOLHbmwoaWloLRC6JdVY/LGnhnJe/pOHqCQEeznnTerxg7kyo0k2m2hXTGaU+2l5NXieZP+OfsGwEH8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=luWTWLdEtObbNIm04ouGXx0/VeG/IIpM1tRllzw6JZw=;
 b=XX9p1FqghkB07ATUAe5B4r7qgAHg16oWdeWByj5xDduUJHfhfk5k4m0RYHNQQ9Rpo4e8SObsrKpjss+jaXOshUaqmKCfZBiD92xa7y3ly20oOp1YgGdk6s5H/safEdXdounh03hzdHvlsNDtuzKXeL4DSiVdWIIciPr1yd7VjSI=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB4051.namprd10.prod.outlook.com (2603:10b6:a03:1b1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31; Sun, 21 Feb
 2021 17:45:09 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3868.031; Sun, 21 Feb 2021
 17:45:09 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Timo Rothenpieler <timo@rothenpieler.org>
CC:     Olga Kornievskaia <aglo@umich.edu>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: copy_file_range() infinitely hangs on NFSv4.2 over RDMA
Thread-Topic: copy_file_range() infinitely hangs on NFSv4.2 over RDMA
Thread-Index: AQHXAoMfawdRzWrgDkSpe5/TYHEFmapbOyaAgAAHBQCAAB6ZgIABlTwAgAArPQCAACy3AIAA0KWSgAAkhACAAB9zAIABZJ0AgAACxwCAAANsgIAADTqAgAG4DICAAVrpgA==
Date:   Sun, 21 Feb 2021 17:45:09 +0000
Message-ID: <5196DB85-0629-4FF4-9DD4-D5019AD94527@oracle.com>
References: <57f67888-160f-891c-6217-69e174d7e42b@rothenpieler.org>
 <CAN-5tyE4OyNOZRXGnyONcdGsHaRAF39LSE5416Kj964m-+_C2A@mail.gmail.com>
 <81cb9aef-c10d-f11c-42c0-5144ee2608bc@rothenpieler.org>
 <0e49471c-e640-a331-c7b4-4e0a49a7a967@rothenpieler.org>
 <CAN-5tyG9Ly9tqKxguFNhg_PGXCxE2=Zn6LQPLY59twdVkD3Auw@mail.gmail.com>
 <51a8caa7-52c2-8155-10a7-1e8d21866924@rothenpieler.org>
 <CAN-5tyFT4+kkqk6E0Jxe-vMYm7q5mHyTeq0Ht7AEYasA30ZaGw@mail.gmail.com>
 <3f946e6b-6872-641c-8828-35ddd5c8fed0@rothenpieler.org>
 <e89ab742-7984-6a2c-2f01-402283ba6e89@rothenpieler.org>
 <CAN-5tyGhyh0ZF77voaN4TNgMt+jSUG0PMp-KixfTvgUhDdhDUQ@mail.gmail.com>
 <def12560-2481-b17d-5a42-7236edbd5392@rothenpieler.org>
 <CAN-5tyHLRn4HEs9R291N6Y=boOvQ9-qvKfJzA8Khkqie2kVVWQ@mail.gmail.com>
 <6478B738-0C33-46DC-B711-B0BF7069FD82@oracle.com>
 <19c74710-bf35-6412-dd06-071331419ab5@rothenpieler.org>
 <E4BAC726-2FFA-47A8-A1B6-F0D2848ABB98@oracle.com>
 <14ca46ac-6b3f-5e51-e4f6-bf4d5dc9933b@rothenpieler.org>
In-Reply-To: <14ca46ac-6b3f-5e51-e4f6-bf4d5dc9933b@rothenpieler.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: rothenpieler.org; dkim=none (message not signed)
 header.d=none;rothenpieler.org; dmarc=none action=none
 header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cd2ecc88-e92d-456e-c19f-08d8d6906eaa
x-ms-traffictypediagnostic: BY5PR10MB4051:
x-microsoft-antispam-prvs: <BY5PR10MB405156F76BC4920C67084E0493829@BY5PR10MB4051.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SNfy1TOz1oKHL42tj0qnkJDt6NAOD5iG/wxyCItvEwPswyG2qem1v8e6C16braa5TL8KGg8NeQRRFj/3zDS9fZaleScg7sCUTtGsVFm7hLKxxASkzlyEVbX6rOlCH79Qc1m52KZwd42tQI5DDD3x5mXpcvx1Q0mGQNsklEFuzl3I/QQS3qUm6s3NUuf50ESZcGIVfYn0xmjl8TPhNLS0/KXcQwBfx2VJO7T7RQJmXXOXZRSCETWBeaarngvLHlvqDN0pASxB3naRM+8O09fdBJe0JcYfy8wis3DLXB30LLytEwpWcSl6tms5Dji8NVio7lwYGzKXK17URB0EyQ3DWmWv1dlsd636nBmjOHhLiQTYhlY6E46SaSLcQJ/YUl9EO8njAaSzt7UPKUdRKhnePN8qQNuVPGeBES/neFZoTrlsi7Sr+sFpI/7D67FUpZDFsDOX821i0kpdA2GQ6yq4jSpkrr0uWJHglrAgv2hTJhZbSf8LFu0hP1Z8qJciriJlC9uaPFuA3PhFhNWFyJ8eGdnf2v2C4EmIFjhNkxszozgA2HA6d70LKVHPiWZhi4Jg8w44Iglz0K2RJqc+Rn5tsA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(39860400002)(366004)(376002)(346002)(6512007)(84040400003)(6506007)(2616005)(64756008)(66446008)(44832011)(4326008)(2906002)(8936002)(316002)(71200400001)(86362001)(54906003)(8676002)(83380400001)(66556008)(478600001)(6916009)(5660300002)(91956017)(33656002)(76116006)(6486002)(186003)(26005)(36756003)(53546011)(66476007)(66946007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?gxVgwJMNNLiLN4xcX1rZV23mL1pMGZTNXRmuZq0THiHamEWg46bsu0YxYC8v?=
 =?us-ascii?Q?Jh5fkJNZqC5t5t9d+o9jSYzjzKFpBc7kIkO/udklBt2KhrN1J2riRAnm+LmG?=
 =?us-ascii?Q?dTkQTndu5l9nlMrA2lxBmsPPF/96dgnAVGoTPsw4cMgssyD5C7stFJ5gPZeg?=
 =?us-ascii?Q?wlPI/8OkwGk/fC48qYEsNoTNmNTZIv8zx/0UxynNUUMHnUTry5/tDU6TpOME?=
 =?us-ascii?Q?V4GLTkelaqN5S712kVkW1XuLAC469C812MI8TLml3q08fUnMZAsnqoltbKQ0?=
 =?us-ascii?Q?Zi1y0AmejtbcWYUQV4MvTdLLwW2ljjCs9blhC/4wnAncBmTVtu5RMsOLMjnn?=
 =?us-ascii?Q?rNsidFtlt85itJlfr0DmsnpFdeZ+z/+D2X6XrfYVealZMwdh/a4WYWWRJIAj?=
 =?us-ascii?Q?IAX3asYa+8TJMEc8AwQ9nFLhjNxxhQ80WCgsE7bPhhX6eQdcuz6H4r9m3nRK?=
 =?us-ascii?Q?IYROdeuc4hsSNZOISNVVhKECuL6mF8DCj5IABfzI+OGCqz06GOsEGzqRF2Bc?=
 =?us-ascii?Q?un0a8y+fNzEj7V8yRVnrFQNXiaBzu7eDERioVAbF0JrLj8lCFKdUK3/YJlDx?=
 =?us-ascii?Q?nO94W/b/18QuDZ+0KrxuS3drMb+mfGZiDBOfdMMwf6dZuhJgCpTC8hRSpdDE?=
 =?us-ascii?Q?5GDAqGYxwyQtRz3Cvtg3pAHayXWBEeHnZ1IQeY1oynCAdnprVC5+pG07pI+3?=
 =?us-ascii?Q?pe08XIfCwY0FRzeqpYgiAL/vu4pWrzrirJWBCfXYkaLKUrdQPCwQdmKMo+9I?=
 =?us-ascii?Q?nb+a78OPn6ZhRZUsCeHQGGTYA1Ns1saLdISxG41SAwKG9558IoPRD0DVMNxq?=
 =?us-ascii?Q?L6g6Ucw7Mb3m6sSTuzfrzoQjCPEvQ4Q4R9PPQdk+NhLAeOwgmMLwU0iMGixP?=
 =?us-ascii?Q?W6OQ7z+amC7za1s9cDHbsJddJTvjtSu28ogCmk0rZ2Mc5zIxYCobSoHplV2+?=
 =?us-ascii?Q?jmAuc9ULkw0hAUf79sZaY/+WZ+IQSie9sswIYC6ZqRwaG8klBZqskHrM/D2j?=
 =?us-ascii?Q?DAVg4oZ2tPBRD0gFo803SxrF1EZtUlC8WWolcFLYa8UB1RbcLTymGRLm7rSo?=
 =?us-ascii?Q?RfsaJNpAvOMMv506XPo40HPiTF6O8G/43qI0kMHBpvUeb8cte3gWrgUDWxDz?=
 =?us-ascii?Q?xtQef5mHD2eBLZI2Ob0EviSpvBn4LLblk2PVInm2JjKgs9r841wgjKSTSdRe?=
 =?us-ascii?Q?PERYQxRMyqNH6qVxmTFU+InHQmzjBvIQQ6aiLLr7TgWS9rAJy8jI1kvg7biu?=
 =?us-ascii?Q?QJNKeD7IsNXM56AbhDNj9n+hmTTSmv9LdOgThCmVK5gO7r/w+OMISDq2RDLh?=
 =?us-ascii?Q?7NcIQBUAdbi2ruPjZuJ5r5AN?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <191D7EB11D1188428FF847F3044B54B1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd2ecc88-e92d-456e-c19f-08d8d6906eaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2021 17:45:09.2308
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q/2ZlB1/aC/ZdHFcbTNE5YAbQn/Ti+UYChKsnpI2/OLsbzWCTNPydn+nJ5/yH1TlFjfIfzR7nS8XB9GlwbXMRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4051
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9902 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102210179
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9902 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102210180
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 20, 2021, at 4:03 PM, Timo Rothenpieler <timo@rothenpieler.org> wr=
ote:
>=20
> On 19.02.2021 19:48, Chuck Lever wrote:
>>> On Feb 19, 2021, at 1:01 PM, Timo Rothenpieler <timo@rothenpieler.org> =
wrote:
>>>=20
>>> On 19.02.2021 18:48, Chuck Lever wrote:
>>>>> On Feb 19, 2021, at 12:38 PM, Olga Kornievskaia <aglo@umich.edu> wrot=
e:
>>>>>=20
>>>>> On Thu, Feb 18, 2021 at 3:22 PM Timo Rothenpieler <timo@rothenpieler.=
org> wrote:
>>>>>>=20
>>>>>> On 18.02.2021 19:30, Olga Kornievskaia wrote:
>>>>>>> Thank you for getting tracepoints from a busy server but can you ge=
t
>>>>>>> more? As suspected, the server is having issues sending the callbac=
k.
>>>>>>> I'm not sure why. Any chance to turn on the server's sunrpc
>>>>>>> tracespoints, probably both sunrpc and rdmas tracepoints, I wonder =
if
>>>>>>> we can any more info about why it's failing?
>>>>>>=20
>>>>>> I isolated out two of the machines on that cluster now, one acting a=
s
>>>>>> NFS server from an ext4 mount, the other is the same client as befor=
e.
>>>>>> That way I managed to capture a trace and ibdump of an entire cycle:
>>>>>> mount + successful copy + 5 minutes later a copy that got stuck
>>>>>>=20
>>>>>> Next to no noise happened during those traces, you can find them att=
ached.
>>>>>>=20
>>>>>> Another observation made due to this: unmount and re-mounting the NF=
S
>>>>>> share also gets it back into working condition for a while, no reboo=
t
>>>>>> necessary.
>>>>>> During this trace, I got "lucky", and after just 5 minutes of waitin=
g,
>>>>>> it got stuck.
>>>>>>=20
>>>>>> Before that, I had a run of mount + trying to copy every 5 minutes w=
here
>>>>>> it ran for 45 minutes without getting stuck. At which point I decide=
d to
>>>>>> remount once more.
>>>>>=20
>>>>> Timo, thank you for gathering the debug info.
>>>>>=20
>>>>> Chuck, I need your help. Why would the server lose a callback channel=
?
>>>>>=20
>>>>>           <...>-1461944 [001] 2076465.200151: rpc_request:
>>>>> task:57752@6 nfs4_cbv1 CB_OFFLOAD (async)
>>>>>           <...>-1461944 [001] 2076465.200151: rpc_task_run_action:
>>>>> task:57752@6 flags=3DASYNC|DYNAMIC|SOFT|NOCONNECT
>>>>> runstate=3DRUNNING|ACTIVE status=3D0 action=3Dcall_reserve
>>>>>           <...>-1461944 [001] 2076465.200154: xprt_reserve:
>>>>> task:57752@6 xid=3D0x00a0aaf9
>>>>>           <...>-1461944 [001] 2076465.200155: rpc_task_run_action:
>>>>> task:57752@6 flags=3DASYNC|DYNAMIC|SOFT|NOCONNECT
>>>>> runstate=3DRUNNING|ACTIVE status=3D0 action=3Dcall_reserveresult
>>>>>           <...>-1461944 [001] 2076465.200156: rpc_task_run_action:
>>>>> task:57752@6 flags=3DASYNC|DYNAMIC|SOFT|NOCONNECT
>>>>> runstate=3DRUNNING|ACTIVE status=3D0 action=3Dcall_refresh
>>>>>           <...>-1461944 [001] 2076465.200163: rpc_task_run_action:
>>>>> task:57752@6 flags=3DASYNC|DYNAMIC|SOFT|NOCONNECT
>>>>> runstate=3DRUNNING|ACTIVE status=3D0 action=3Dcall_refreshresult
>>>>>           <...>-1461944 [001] 2076465.200163: rpc_task_run_action:
>>>>> task:57752@6 flags=3DASYNC|DYNAMIC|SOFT|NOCONNECT
>>>>> runstate=3DRUNNING|ACTIVE status=3D0 action=3Dcall_allocate
>>>>>           <...>-1461944 [001] 2076465.200168: rpc_buf_alloc:
>>>>> task:57752@6 callsize=3D548 recvsize=3D104 status=3D0
>>>>>           <...>-1461944 [001] 2076465.200168: rpc_task_run_action:
>>>>> task:57752@6 flags=3DASYNC|DYNAMIC|SOFT|NOCONNECT
>>>>> runstate=3DRUNNING|ACTIVE status=3D0 action=3Dcall_encode
>>>>>           <...>-1461944 [001] 2076465.200173: rpc_task_run_action:
>>>>> task:57752@6 flags=3DASYNC|DYNAMIC|SOFT|NOCONNECT
>>>>> runstate=3DRUNNING|ACTIVE|NEED_XMIT|NEED_RECV status=3D0
>>>>> action=3Dcall_connect
>>>>>           <...>-1461944 [001] 2076465.200174: rpc_call_rpcerror:
>>>>> task:57752@6 tk_status=3D-107 rpc_status=3D-107
>>>>>           <...>-1461944 [001] 2076465.200174: rpc_task_run_action:
>>>>> task:57752@6 flags=3DASYNC|DYNAMIC|SOFT|NOCONNECT
>>>>> runstate=3DRUNNING|ACTIVE|NEED_XMIT|NEED_RECV status=3D-107
>>>>> action=3Drpc_exit_task
>>>>>=20
>>>>> It's reporting ENOTCON. I'm not really sure if this is related to cop=
y
>>>>> offload but more perhaps doing callbacks over RDMA/IB.
>>>> If the client is awaiting a COPY notification callback, I can see why
>>>> a lost CB channel would cause the client to wait indefinitely.
>>>> The copy mechanism has to deal with this contingency... Perhaps the
>>>> server could force a disconnect so that the client and server have an
>>>> opportunity to re-establish the callback channel. <shrug>
>>>> In any event, the trace log above shows nothing more than "hey, it's
>>>> not working." Are there any rpcrdma trace events we can look at to
>>>> determine why the backchannel is getting lost?
>>>=20
>>> The trace log attached to my previous mail has it enabled, along with n=
fsd and sunrpc.
>>> I'm attaching the two files again here.
>> Thanks, Timo.
>> The first CB_OFFLOAD callback succeeds:
>> 2076155.216687: nfsd_cb_work:         addr=3D10.110.10.252:0 client 602e=
b645:daa037ae procedure=3DCB_OFFLOAD
>> 2076155.216704: rpc_request:          task:57746@6 nfs4_cbv1 CB_OFFLOAD =
(async)
>> 2076155.216975: rpc_stats_latency:    task:57746@6 xid=3D0xff9faaf9 nfs4=
_cbv1 CB_OFFLOAD backlog=3D33 rtt=3D195 execute=3D282
>> 2076155.216977: nfsd_cb_done:         addr=3D10.110.10.252:0 client 602e=
b645:daa037ae status=3D0
>> About 305 seconds later, the autodisconnect timer fires. I'm not sure if=
 this is the backchannel transport, but it looks suspicious:
>> 2076460.314954: xprt_disconnect_auto: peer=3D[10.110.10.252]:0 state=3DL=
OCKED|CONNECTED|BOUND
>> 2076460.314957: xprt_disconnect_done: peer=3D[10.110.10.252]:0 state=3DL=
OCKED|CONNECTED|BOUND
>> The next CB_OFFLOAD callback fails because the xprt has been marked "dis=
connected" and the request's NOCONNECT flag is set.
>> 2076465.200136: nfsd_cb_work:         addr=3D10.110.10.252:0 client 602e=
b645:daa037ae procedure=3DCB_OFFLOAD
>> 2076465.200151: rpc_request:          task:57752@6 nfs4_cbv1 CB_OFFLOAD =
(async)
>> 2076465.200168: rpc_task_run_action:  task:57752@6 flags=3DASYNC|DYNAMIC=
|SOFT|NOCONNECT runstate=3DRUNNING|ACTIVE status=3D0 action=3Dcall_encode
>> 2076465.200173: rpc_task_run_action:  task:57752@6 flags=3DASYNC|DYNAMIC=
|SOFT|NOCONNECT runstate=3DRUNNING|ACTIVE|NEED_XMIT|NEED_RECV status=3D0 ac=
tion=3Dcall_connect
>> 2076465.200174: rpc_call_rpcerror:    task:57752@6 tk_status=3D-107 rpc_=
status=3D-107
>> 2076465.200174: rpc_task_run_action:  task:57752@6 flags=3DASYNC|DYNAMIC=
|SOFT|NOCONNECT runstate=3DRUNNING|ACTIVE|NEED_XMIT|NEED_RECV status=3D-107=
 action=3Drpc_exit_task
>> 2076465.200179: nfsd_cb_done:         addr=3D10.110.10.252:0 client 602e=
b645:daa037ae status=3D-107
>> 2076465.200180: nfsd_cb_state:        addr=3D10.110.10.252:0 client 602e=
b645:daa037ae state=3DFAULT
>> Perhaps RPC clients for NFSv4.1+ callback should be created with
>> the RPC_CLNT_CREATE_NO_IDLE_TIMEOUT flag.
>=20
> I added that flag to the callback client creation flags, and so far after=
 a few hours of uptime, copying still works.

It seems like a good thing to do in any event (barring any other observatio=
ns).
Can you send a patch for review?


> Can't say anything about that being the appropriate fix for the issue at =
hand, as I lack the necessary insight into the NFS code, but I'll leave it =
running like that for now and observe.
>=20
> Can also gladly test any other patches.
>=20
>=20
> Thanks,
> Timo

--
Chuck Lever



