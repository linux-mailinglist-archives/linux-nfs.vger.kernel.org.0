Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4035031FEF7
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Feb 2021 19:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhBSStY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 19 Feb 2021 13:49:24 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:59040 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbhBSStX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 19 Feb 2021 13:49:23 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11JImWu2121597;
        Fri, 19 Feb 2021 18:48:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=pFcKqPfC6goWFJ4oOvMP03muArNy/baGgtPmE9nZxLQ=;
 b=VS+LVUFYnFNtSp54I4HaSHpiEiCpBFpG/pctRi0Seu9+kDuAnRbUvnYrSyOuVbtMY6ur
 Uj3fkJ1slQwuR0/sEJoNqEjiSsEenI1coIwJ2oWgyYUlIS8QnYTuJh/ruGeWejY4oO2R
 C8eqmzxIuS9P+4Y0xChTzzrmfSfJNbPlko+i8cPYSrhGwY7MmUvnTn99zRRh/otvxIrK
 9vqlMYsUXuXwmm5UHhekyTxQdFMDhAamY7/2dLb0g5tjqLdfC/oukrh08f9jffUtF3SL
 f46SrBE4rTCUEVib4jxTyLc2cg1lA3zqQ3DlM0sIyg4/4yYZ5hIimOol5AXzh0fBl1Gg 7A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 36p49bjmm7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Feb 2021 18:48:32 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11JIkVJb083535;
        Fri, 19 Feb 2021 18:48:32 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by aserp3030.oracle.com with ESMTP id 36prbsemkv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Feb 2021 18:48:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FYkPxJzrJNUy5H1frrKq5sypu8nOhvfyG2RsxLFCEE6qGlXdoq02EfRL9cqyAHiRnosKR80Xb/WFm7QW/DmgNh85THBDDMH1ZynouoJskRzSaKP7D5ySzhRH6FcQzuwPqWkwCTKam3n3Auz2kavnGULo5pLq/OFDtuLahaA64Y8YnlbyrnHD7r9qeKMzFLmqFDcNTIkQm5XDM0Qp/A05N0Em12ybykn7mV4sLimpkHw/8VnxDUQ6+oTQQaGdsLjTGlWm3Ofok75fZ8B44oFofTIkcyJ/HrUAC5EGUdBwucWVW6S0CTAzu+KA6/HnLUZYmcAlY2CtP0MRQbzsxpkGUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pFcKqPfC6goWFJ4oOvMP03muArNy/baGgtPmE9nZxLQ=;
 b=hpepO+6fXLwpvyfKj+jPX+JvPuS6Yolfn4Fcj2oq4y76Z3pdMCehuaYoDnj96NZRci7YhyJiCp0qYyPtmcphjjT+fg6LnXswOF3eYyT0bzROtfZR1j+1+YmIYHttjk1FltLdO6V8IckuVT6MMTmFf1HdfYAosYIpK6PNDvSpYubcnlf6e2TCbBCWqCuZuzr79ZDu4hhxMht/ZUwyY/lHqsgb4NmBC4IaUDXdizKsBSKJsNpE+CsvlZPuneaVm6tf4slOSU/ovVQgJ9BAT8OAuWsar+6GF+wmwR/T8Zxz70yoZHptp+4c2sMwx3FN4lOQZ+2bywV7HhO/POUyLbAIGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pFcKqPfC6goWFJ4oOvMP03muArNy/baGgtPmE9nZxLQ=;
 b=UGdk7n/0BMdn2oKQdUtQl/S+f40YMH68DOrrrqpWCdplEZ8Sz5TjQ6Rk8imBqmLsNkNdrdJv3LCdiJn+MGnvbP8L3q8kNz7wMMFrNhP1krIbVKNQo85kVKrnLsk1ntUWbpAR8ng2hpXNMisrlBIt03lP4XK95i8S+F8fx+6rQbQ=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB4147.namprd10.prod.outlook.com (2603:10b6:a03:20e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Fri, 19 Feb
 2021 18:48:30 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3846.043; Fri, 19 Feb 2021
 18:48:30 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Timo Rothenpieler <timo@rothenpieler.org>,
        Olga Kornievskaia <aglo@umich.edu>
CC:     linux-rdma <linux-rdma@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: copy_file_range() infinitely hangs on NFSv4.2 over RDMA
Thread-Topic: copy_file_range() infinitely hangs on NFSv4.2 over RDMA
Thread-Index: AQHXAoMfawdRzWrgDkSpe5/TYHEFmapbOyaAgAAHBQCAAB6ZgIABlTwAgAArPQCAACy3AIAA0KWSgAAkhACAAB9zAIABZJ0AgAACxwCAAANsgIAADTqA
Date:   Fri, 19 Feb 2021 18:48:30 +0000
Message-ID: <E4BAC726-2FFA-47A8-A1B6-F0D2848ABB98@oracle.com>
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
In-Reply-To: <19c74710-bf35-6412-dd06-071331419ab5@rothenpieler.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: rothenpieler.org; dkim=none (message not signed)
 header.d=none;rothenpieler.org; dmarc=none action=none
 header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d2783e78-113f-4156-56af-08d8d506f35f
x-ms-traffictypediagnostic: BY5PR10MB4147:
x-microsoft-antispam-prvs: <BY5PR10MB41476D9B50104FD89DE3490D93849@BY5PR10MB4147.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aidAK1bh9M1XBuCpwzo/9Occf2AQFYN3DaqgExdlWgeCUfGBOjVUHgwIG0oIeyOQQ0qTzEOxp8Xmb2RkQc3/E3anPxsMqMacuJInrRNdMlrSFko4EpJBI0F2Z8LiIQoqpKDJZBYp32/6zSCt8rPrY2/SYkF4AkNjyiHBKWAE37v674ryjyQqTXAzgKwPuXdjf3qN07GSiCU8FGiF0U0hKbto6tKz33ejZpKTDo1wwt2u5e+zXXbe6klE4M2xus7UvuqbcSxzYQ1KQ47pyXw1/VRfWYmbGkXlhKtcNChi3uecoWQlNkMfS0EDdZFFewUfXbGIb5UaR/vA4qiaF9ED9EKv75uR0bkiOOhn+Kvfposl2fGxzBCG4ieJc/rbXkr0luoTm/7XJh2M/0Cnak620xD46P52IOEYdfLempKv7ickbpBi+f6T3OieFvS7b397scFH7ZdPIPBmaLw54IK0mnLASOYThJkIvVshQr5ij3Td58FC0tAx7q49gQTb+jhwzKHMr/Lg5oXUkTCKaVk3HthuVFgbVlHupdV3/bYkbShTG5kDohB+3C9Bxuc3ev2sEUkBWH+LCJVGAk0ZfwQcMQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(396003)(39860400002)(376002)(346002)(26005)(6486002)(4326008)(478600001)(71200400001)(8676002)(6506007)(2906002)(186003)(316002)(83380400001)(84040400003)(2616005)(53546011)(54906003)(66556008)(6512007)(86362001)(91956017)(76116006)(66946007)(36756003)(110136005)(44832011)(8936002)(66476007)(5660300002)(66446008)(33656002)(64756008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?fV7XP5x6jTLpRJ6DE+Cli7Wpn280TNd33Vi34FuikhRFiwrR1yWD8gJj1ANA?=
 =?us-ascii?Q?Q65rMZKCnIToI7XagN/n11bEONnZQJdBKCjCpa3qUOjTTanppxYZOPf5wyxY?=
 =?us-ascii?Q?QVR/80kK4nBi4DNj0Fb97c1AELX1SU3rPCAsmc2tu8KffdlmKB31FelfuHOX?=
 =?us-ascii?Q?TJ6lmI9z6HipEUXr7/LVVy2YyQDhZdEw1V82tkndSQPeCP0a+FSo5PRVWuqe?=
 =?us-ascii?Q?PkJFXVq/EqP9kVpgY3MuaZaB25EOJAEpCTuxProf0hU1VgD2Xhh2K45FGj30?=
 =?us-ascii?Q?kYktu4hWTe0JBxDc/RwVglyyYhFKcY7ug1/SEiT6i7r2q5ad+TH1eFZVCMrA?=
 =?us-ascii?Q?IOAopneehCzblqou8UPvRoBXOybfwat6XyAyhpq+xuA3zDXyWe7b2tsUfbX4?=
 =?us-ascii?Q?//5U2PpDbwQmnuaisEs6hiH95FezDFBZvn0SKPO2xlFhDWAkKVaGK6+QVdR/?=
 =?us-ascii?Q?AdkpwAimp7MdXC3gWwHKdD6u1xedA+pmsvOPnmJOFPzfHfrVFxMH9pFUlPxT?=
 =?us-ascii?Q?BX8PjW9TddUUiOENwAWnzG0vQuVFeKOsOSVXaEoxav6EGPoiAmDeoUchMtpS?=
 =?us-ascii?Q?tluK+DZKzdiR6h2zgU8w8K+YVI0LBxnZb+4nnNpwffUe8ZHu3nbtWY9vZkbf?=
 =?us-ascii?Q?c8IsWOF1jrFrHNt0uIjGzqnhnBY1IJDsVjeIzZIqsWYOPiHG4aPjDwaJd9tG?=
 =?us-ascii?Q?sgIr5ea55nvFZ6O5pxbGZea9NHLse7jgxyWpoS33JHMjeKprji0PjNPr6HCw?=
 =?us-ascii?Q?QdHZlYnCM/T7mr0mxeoORCEfELK3LhPQb9rZakv415xcwLsNBQH9o1SPERD8?=
 =?us-ascii?Q?hlNDPF8FlsQrp/EM19sbxM+us4SBDl1eDCqMCbhcR7G7J4Z6wkNKTIEb8Vgb?=
 =?us-ascii?Q?WXNef+WPE2mWg1XWn2oB0UjBTvfLf1VOxr/aPUjCNYedTRVneS2WaUrS/kzN?=
 =?us-ascii?Q?yzjcA4Oz1maFyy8m26S9Gfv23q/KTcrpMRhSSzkQSnJX6GKvqY0c+blkhWx1?=
 =?us-ascii?Q?CwItEIuWY5TvrS8hKgeferTddbzAx+LtFxMzQ+WwW5WCjOW/19dMaAf7Dupy?=
 =?us-ascii?Q?0CG1Mxzrt8uEyFbWGyyazyEJVFcPxUVp8Xb+/pLg1R+Z8DGOJ1vl8xbj6TQD?=
 =?us-ascii?Q?idSm9ykOmYc7LtDRok2wtwYte7ibBGOdOQyceBhxESa+vAIzyLpes34hZv4f?=
 =?us-ascii?Q?wnqAiydSN/QPs4WsBB4gQHFHY7Dwcp6lRqlwro/ov+VPCzO5LaYMiDRu5bJ4?=
 =?us-ascii?Q?dhB5tzL1Y8Vbo+bUBRx3kQyS0wSVnkk+uLHT1Pzo1wv8CCHnaMRbn+qgm+/L?=
 =?us-ascii?Q?oUyF2KU0/UrTCbd7X+8TIkfD?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <75A73CDAA780F74FA0F91F17E107996E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2783e78-113f-4156-56af-08d8d506f35f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2021 18:48:30.1531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xbxrPK4bnJgFXzTNb7loBymGjt9SFSWkur4WpWEd95e29PL7B0ZSYXUBMoHXzekINS+vHM/bIClpcJFQUyGh0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4147
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9900 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 phishscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102190146
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9900 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 phishscore=0 clxscore=1015 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102190146
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 19, 2021, at 1:01 PM, Timo Rothenpieler <timo@rothenpieler.org> wr=
ote:
>=20
> On 19.02.2021 18:48, Chuck Lever wrote:
>>> On Feb 19, 2021, at 12:38 PM, Olga Kornievskaia <aglo@umich.edu> wrote:
>>>=20
>>> On Thu, Feb 18, 2021 at 3:22 PM Timo Rothenpieler <timo@rothenpieler.or=
g> wrote:
>>>>=20
>>>> On 18.02.2021 19:30, Olga Kornievskaia wrote:
>>>>> Thank you for getting tracepoints from a busy server but can you get
>>>>> more? As suspected, the server is having issues sending the callback.
>>>>> I'm not sure why. Any chance to turn on the server's sunrpc
>>>>> tracespoints, probably both sunrpc and rdmas tracepoints, I wonder if
>>>>> we can any more info about why it's failing?
>>>>=20
>>>> I isolated out two of the machines on that cluster now, one acting as
>>>> NFS server from an ext4 mount, the other is the same client as before.
>>>> That way I managed to capture a trace and ibdump of an entire cycle:
>>>> mount + successful copy + 5 minutes later a copy that got stuck
>>>>=20
>>>> Next to no noise happened during those traces, you can find them attac=
hed.
>>>>=20
>>>> Another observation made due to this: unmount and re-mounting the NFS
>>>> share also gets it back into working condition for a while, no reboot
>>>> necessary.
>>>> During this trace, I got "lucky", and after just 5 minutes of waiting,
>>>> it got stuck.
>>>>=20
>>>> Before that, I had a run of mount + trying to copy every 5 minutes whe=
re
>>>> it ran for 45 minutes without getting stuck. At which point I decided =
to
>>>> remount once more.
>>>=20
>>> Timo, thank you for gathering the debug info.
>>>=20
>>> Chuck, I need your help. Why would the server lose a callback channel?
>>>=20
>>>           <...>-1461944 [001] 2076465.200151: rpc_request:
>>> task:57752@6 nfs4_cbv1 CB_OFFLOAD (async)
>>>           <...>-1461944 [001] 2076465.200151: rpc_task_run_action:
>>> task:57752@6 flags=3DASYNC|DYNAMIC|SOFT|NOCONNECT
>>> runstate=3DRUNNING|ACTIVE status=3D0 action=3Dcall_reserve
>>>           <...>-1461944 [001] 2076465.200154: xprt_reserve:
>>> task:57752@6 xid=3D0x00a0aaf9
>>>           <...>-1461944 [001] 2076465.200155: rpc_task_run_action:
>>> task:57752@6 flags=3DASYNC|DYNAMIC|SOFT|NOCONNECT
>>> runstate=3DRUNNING|ACTIVE status=3D0 action=3Dcall_reserveresult
>>>           <...>-1461944 [001] 2076465.200156: rpc_task_run_action:
>>> task:57752@6 flags=3DASYNC|DYNAMIC|SOFT|NOCONNECT
>>> runstate=3DRUNNING|ACTIVE status=3D0 action=3Dcall_refresh
>>>           <...>-1461944 [001] 2076465.200163: rpc_task_run_action:
>>> task:57752@6 flags=3DASYNC|DYNAMIC|SOFT|NOCONNECT
>>> runstate=3DRUNNING|ACTIVE status=3D0 action=3Dcall_refreshresult
>>>           <...>-1461944 [001] 2076465.200163: rpc_task_run_action:
>>> task:57752@6 flags=3DASYNC|DYNAMIC|SOFT|NOCONNECT
>>> runstate=3DRUNNING|ACTIVE status=3D0 action=3Dcall_allocate
>>>           <...>-1461944 [001] 2076465.200168: rpc_buf_alloc:
>>> task:57752@6 callsize=3D548 recvsize=3D104 status=3D0
>>>           <...>-1461944 [001] 2076465.200168: rpc_task_run_action:
>>> task:57752@6 flags=3DASYNC|DYNAMIC|SOFT|NOCONNECT
>>> runstate=3DRUNNING|ACTIVE status=3D0 action=3Dcall_encode
>>>           <...>-1461944 [001] 2076465.200173: rpc_task_run_action:
>>> task:57752@6 flags=3DASYNC|DYNAMIC|SOFT|NOCONNECT
>>> runstate=3DRUNNING|ACTIVE|NEED_XMIT|NEED_RECV status=3D0
>>> action=3Dcall_connect
>>>           <...>-1461944 [001] 2076465.200174: rpc_call_rpcerror:
>>> task:57752@6 tk_status=3D-107 rpc_status=3D-107
>>>           <...>-1461944 [001] 2076465.200174: rpc_task_run_action:
>>> task:57752@6 flags=3DASYNC|DYNAMIC|SOFT|NOCONNECT
>>> runstate=3DRUNNING|ACTIVE|NEED_XMIT|NEED_RECV status=3D-107
>>> action=3Drpc_exit_task
>>>=20
>>> It's reporting ENOTCON. I'm not really sure if this is related to copy
>>> offload but more perhaps doing callbacks over RDMA/IB.
>> If the client is awaiting a COPY notification callback, I can see why
>> a lost CB channel would cause the client to wait indefinitely.
>> The copy mechanism has to deal with this contingency... Perhaps the
>> server could force a disconnect so that the client and server have an
>> opportunity to re-establish the callback channel. <shrug>
>> In any event, the trace log above shows nothing more than "hey, it's
>> not working." Are there any rpcrdma trace events we can look at to
>> determine why the backchannel is getting lost?
>=20
> The trace log attached to my previous mail has it enabled, along with nfs=
d and sunrpc.
> I'm attaching the two files again here.

Thanks, Timo.

The first CB_OFFLOAD callback succeeds:

2076155.216687: nfsd_cb_work:         addr=3D10.110.10.252:0 client 602eb64=
5:daa037ae procedure=3DCB_OFFLOAD
2076155.216704: rpc_request:          task:57746@6 nfs4_cbv1 CB_OFFLOAD (as=
ync)

2076155.216975: rpc_stats_latency:    task:57746@6 xid=3D0xff9faaf9 nfs4_cb=
v1 CB_OFFLOAD backlog=3D33 rtt=3D195 execute=3D282
2076155.216977: nfsd_cb_done:         addr=3D10.110.10.252:0 client 602eb64=
5:daa037ae status=3D0


About 305 seconds later, the autodisconnect timer fires. I'm not sure if th=
is is the backchannel transport, but it looks suspicious:

2076460.314954: xprt_disconnect_auto: peer=3D[10.110.10.252]:0 state=3DLOCK=
ED|CONNECTED|BOUND
2076460.314957: xprt_disconnect_done: peer=3D[10.110.10.252]:0 state=3DLOCK=
ED|CONNECTED|BOUND


The next CB_OFFLOAD callback fails because the xprt has been marked "discon=
nected" and the request's NOCONNECT flag is set.

2076465.200136: nfsd_cb_work:         addr=3D10.110.10.252:0 client 602eb64=
5:daa037ae procedure=3DCB_OFFLOAD
2076465.200151: rpc_request:          task:57752@6 nfs4_cbv1 CB_OFFLOAD (as=
ync)

2076465.200168: rpc_task_run_action:  task:57752@6 flags=3DASYNC|DYNAMIC|SO=
FT|NOCONNECT runstate=3DRUNNING|ACTIVE status=3D0 action=3Dcall_encode
2076465.200173: rpc_task_run_action:  task:57752@6 flags=3DASYNC|DYNAMIC|SO=
FT|NOCONNECT runstate=3DRUNNING|ACTIVE|NEED_XMIT|NEED_RECV status=3D0 actio=
n=3Dcall_connect
2076465.200174: rpc_call_rpcerror:    task:57752@6 tk_status=3D-107 rpc_sta=
tus=3D-107
2076465.200174: rpc_task_run_action:  task:57752@6 flags=3DASYNC|DYNAMIC|SO=
FT|NOCONNECT runstate=3DRUNNING|ACTIVE|NEED_XMIT|NEED_RECV status=3D-107 ac=
tion=3Drpc_exit_task
2076465.200179: nfsd_cb_done:         addr=3D10.110.10.252:0 client 602eb64=
5:daa037ae status=3D-107
2076465.200180: nfsd_cb_state:        addr=3D10.110.10.252:0 client 602eb64=
5:daa037ae state=3DFAULT


Perhaps RPC clients for NFSv4.1+ callback should be created with
the RPC_CLNT_CREATE_NO_IDLE_TIMEOUT flag.


--
Chuck Lever



