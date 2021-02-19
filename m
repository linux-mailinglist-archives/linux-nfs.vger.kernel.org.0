Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B007F31FE53
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Feb 2021 18:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbhBSRuB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 19 Feb 2021 12:50:01 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:40332 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbhBSRty (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 19 Feb 2021 12:49:54 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11JHislU133327;
        Fri, 19 Feb 2021 17:48:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=BI+Asw0z2hEN5K0J40hPDXRkeKy0L9QEK8IevF+HTDk=;
 b=OB5KmmPHk5Jhf9gxgh4D1hfjp5wwXhMkFLd0DN46H6u66bAlFqwfAGSNM+fPB7RdQYSI
 tbJcOxGbpnj3XkaXExjGWHUEULEZWPMruKZXJMrIY1szhkC55+33IgGBVSpccrnk2gsG
 hSMEfAPDOK7OCRKklHSl1sBEnM33SRTDuC1NhEw5WV+hA25uUWLZ4zHQvimjRI+3iZcR
 adbKHgoHxOej+rDhbEGWkWJ/YnbQPe961m6FK5tbE3EADXB5NUjk2LkYZWo4EfOCBme4
 yd0zys45xoaUniU7t1iyP7qMt0muRe/8RRO3sLCx0rx+6IbzTENEU0vHnMv1DyHO2UKy pQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 36p7dnt7s2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Feb 2021 17:48:58 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11JHkV1K012115;
        Fri, 19 Feb 2021 17:48:57 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2043.outbound.protection.outlook.com [104.47.73.43])
        by aserp3030.oracle.com with ESMTP id 36prbscrrt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Feb 2021 17:48:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f569agOKRosuUaftFa+wYFvelQ+iGAXtuljm+SCqmlUCFcBB+ZYsiR/phihqHnzAyd6lrtFRCheNonQqxRNcbFwWIi5VGT0kyzIoJM8erwxGzJEwmccCHH2otgTqQf3uRKifunmBYDA63DTunwt2H0e0FPXuqSaDg0ivpnvpilnQZmMSu47VQgtfb7KVwVESAodAyH3QstFFl0lZgma+qjTqamb6lOppGT0ow3t4f90H6vOClNvGy4W/JV1c5p69Q+O/VmPJ82TnbWwTPVCby34mOzO5YM27rCMif0ofpuhtXpQqQeBNV/mXEu9y3xZqAET8RKvepxpQrkDBxlFCmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BI+Asw0z2hEN5K0J40hPDXRkeKy0L9QEK8IevF+HTDk=;
 b=R3nFQcSjeKuDJOk95oxzPeCY6XoqJaHTVG+vf8+Ai370jyWwCz73NovAEvE+uJCYpOPTk58mxjwTlaGP/z0/XttxRs+UxTwQS67WLodxxkB14rI0n6HGzDjVcvCPHynxFtGT1by1MCHec2imL6gfY3RLiWVj15Xm2QeoGc+OMOYnwq5LSqIJF4uV0e6tTfhk6BFn4BDEeRAadzEf7qYEqliE17DmNwCUiWJUAkiccc1ALgeMY9shYZihj+E3AqHtIK/cufiQCjIRkqKyZ91Wks7y4OSVQ5vvIH0kexiuBXDjHP+7DcuTZSAfogErOPHFsd2pBX4chebnl8hx9hIgRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BI+Asw0z2hEN5K0J40hPDXRkeKy0L9QEK8IevF+HTDk=;
 b=bQPMD29npxSvO55UVZF0Z11JK+dhHBjEX3D+ZmwCijKz5c16enUBnnmeoJRfahZLnPOJ0OsaOHvb1gtXdyb17rEY/JdZ1PRRmu3ov3yMxVh9IGUmwgdXh9QxLpJtjKGM6YXJ89irqItWmslD+BN+FpYOVwI+2CpBQvNhemJX2oc=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB4194.namprd10.prod.outlook.com (2603:10b6:a03:20f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27; Fri, 19 Feb
 2021 17:48:55 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3846.043; Fri, 19 Feb 2021
 17:48:55 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Olga Kornievskaia <aglo@umich.edu>
CC:     Timo Rothenpieler <timo@rothenpieler.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: copy_file_range() infinitely hangs on NFSv4.2 over RDMA
Thread-Topic: copy_file_range() infinitely hangs on NFSv4.2 over RDMA
Thread-Index: AQHXAoMfawdRzWrgDkSpe5/TYHEFmapbOyaAgAAHBQCAAB6ZgIABlTwAgAArPQCAACy3AIAA0KWSgAAkhACAAB9zAIABZJ0AgAACxwA=
Date:   Fri, 19 Feb 2021 17:48:55 +0000
Message-ID: <6478B738-0C33-46DC-B711-B0BF7069FD82@oracle.com>
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
In-Reply-To: <CAN-5tyHLRn4HEs9R291N6Y=boOvQ9-qvKfJzA8Khkqie2kVVWQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: umich.edu; dkim=none (message not signed)
 header.d=none;umich.edu; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6142df7c-76ca-44f5-6b38-08d8d4fea0a4
x-ms-traffictypediagnostic: BY5PR10MB4194:
x-microsoft-antispam-prvs: <BY5PR10MB41944E0B5F9A36C6E16BBD9293849@BY5PR10MB4194.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vk22jWYwHWpYrgtP5iKyw6Vd5dYubGaWepfeNP9HMZtyLA/QguH3eN/cwo2DpDrG5fiQVkUP9H3yzO84avS7QcnsrFBZKTT/0sf7DoiZD9nkYfig2pbdy/tf969tdL8u7h363x+WCQsi0lzUgpXgpdg81KXF/Reya7et+kO1BGN+dxj2cIkQP8Th4w/W+/IAN+0uNTtkjQrqDWc37O90BmjfrG0ZPBeSC1Iasehk0DRMxSUjKMGZQ6iU5saWjfOoXHnn1H8BPtYkLNO2pCMbcAF0t4YBAfqrz6n5wupeh66jKtg1y3lNn2X5IASf7yedh5FnYKO0fRF8U42aAYwNET0jV25t7Tz2uFbWcVEfADyIheBC2O8OndPa81UiA6TsG6r3CFaA5tUMmIpqdcMxtKTS+ae/ivW4i4nf5QeemNLI5vN3dP4uN/z7QHqqo87yQFxVAZPnMwveyS2pL0GwRx/MqYfEJae0FKsIQk+pP6ACIspusWtI7tvASDLJoGTmbT3Yr81X9PTdZn3+INBZqBBEDSXh3kbG8eJCQZ/PcaIfbgQU9RchhgAYwvaHsx05fP3tEe8JfOspY3osQJ+WPA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(39860400002)(346002)(136003)(366004)(66556008)(91956017)(64756008)(66476007)(76116006)(6486002)(6512007)(66946007)(66446008)(36756003)(33656002)(2906002)(8676002)(84040400003)(6916009)(5660300002)(71200400001)(316002)(53546011)(44832011)(478600001)(26005)(86362001)(2616005)(6506007)(8936002)(186003)(54906003)(4326008)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?b9yxwLC4dycEHFOX+OwdPGZ7geMInAJB8VuGBumL9VpHTt8ckqOTkYPk94Y7?=
 =?us-ascii?Q?/HxFFS8+C7sO5cnJLwCrrU1KmOrXPeQ0K7GYQzteQtYCZEQccq2ZylXv2+Nb?=
 =?us-ascii?Q?qjouJEhK986GOscEnO8RGuN8u5bhmpY/gBVMplET8Sv7ELk66qJX+PcB3pLf?=
 =?us-ascii?Q?1dGRaTMp/Hl+pQTnDXb/P6fINE34aG7TRIX9zID6/8lyZybqI/35JHD1t8PD?=
 =?us-ascii?Q?2ZUlu72ilsyLZKyB3wNU7JvpSAJsJAEWTowJlybtZCbbVzU/mYxRxJYEVLaq?=
 =?us-ascii?Q?7amq9QhOQnV4npqQGofYhNh1K05+Meanj2smkeH/A8UovoilUVT0g/+5EzkO?=
 =?us-ascii?Q?KFpoFKLnBsif16UAdjuyKNWJpFcfn+uiiJrAkNF2ux0a1KfgkXcsJtTzTND5?=
 =?us-ascii?Q?OAbM4xdjSg+qXuVss6GKc8HhONGfMMENTnx4FntU1Croc7n186IrfvQmVYqW?=
 =?us-ascii?Q?8UE4ew/SSj78sf6JKbW2ieza25OqjHGH857zo2pY6RJFU8WsquhCw/O0/UYk?=
 =?us-ascii?Q?8XCfc5XF7Gnl+NGUKp8BkYhM8AT1xhgBlOMk1nohflzd/68f9ehdSmac49zl?=
 =?us-ascii?Q?aLKNUzDLK06olJ4aWEc05+JOsAA4L2tV8EdQYX2z2fUcRBs/fEirN7Erorzx?=
 =?us-ascii?Q?4VxQK2S34TZWNY+Aylf3S9tWEKOTUr8x9duDwIwpouuRx3wNbPRG3Epafqhf?=
 =?us-ascii?Q?rwTtzLFsjd+EOOjpdX7QVNCHbv0ZDYIewZEkqdWSdntdBOlsREbnzRk9V9kf?=
 =?us-ascii?Q?ln3MYyOtkVbULEWKvKpEYFgfqVd3bQ+2qvpZjC5mlj6F/9HCR7sgjPSfPzsY?=
 =?us-ascii?Q?lYjaLQLz9EiA+YX29G0W86Fnho9ElmgUvl7cE58nmf5TiYkggpmc5DFenya4?=
 =?us-ascii?Q?q71590f4c4Hm+llViXmP56mKD6NFQD65iy+TbGNnYOTeJfe4/wrk0SvIs0MF?=
 =?us-ascii?Q?XwwHnLSn6Zv2ahpls0VSopguuTynNonZrztseh9sAM1uWDFI6RE2KQ5zrARo?=
 =?us-ascii?Q?3bMn3vIM9qFKEYV7wwFARH3ZZQl9krWkQktyiTtICLthHlLht2BKHYCpeLee?=
 =?us-ascii?Q?wIUHS7sNeJ1aWIcuWKfuYhkk98sOuAfqD+LIVSDj7N1yjcG9EfeLi7ZmZu6C?=
 =?us-ascii?Q?JfmnXdJ5BsIN9icTm1SxCsPWVrKV7KxTcxJYuew3+qoZ0DkJMNj9HnA0zTrg?=
 =?us-ascii?Q?XEOpHYqYjG+ZGAMBTwRqBgyazexRcVHGs8pid6QDDkGXZJpVQyZHqP98f6s7?=
 =?us-ascii?Q?qWqqewAB15rfu/110xxebQ0xiWmnD/top3Sfs9sUCru5MdTt/jQOP9jD6N6r?=
 =?us-ascii?Q?DTYicTwuW9AIYOQUyYkzOGtZ?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EB0741FE46AFCC49A31383754F6D17F2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6142df7c-76ca-44f5-6b38-08d8d4fea0a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2021 17:48:55.4189
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q+y+eWu6jERlbTquOZ4+AWpijeI/gxP+lsrR1qfdoNOhuKD04LLgN68BtmPc+FcrwBfH5w4K8OTCa/HE4Icbxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4194
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9900 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 phishscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102190139
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9900 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 spamscore=0 adultscore=0 clxscore=1011 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102190139
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 19, 2021, at 12:38 PM, Olga Kornievskaia <aglo@umich.edu> wrote:
>=20
> On Thu, Feb 18, 2021 at 3:22 PM Timo Rothenpieler <timo@rothenpieler.org>=
 wrote:
>>=20
>> On 18.02.2021 19:30, Olga Kornievskaia wrote:
>>> Thank you for getting tracepoints from a busy server but can you get
>>> more? As suspected, the server is having issues sending the callback.
>>> I'm not sure why. Any chance to turn on the server's sunrpc
>>> tracespoints, probably both sunrpc and rdmas tracepoints, I wonder if
>>> we can any more info about why it's failing?
>>=20
>> I isolated out two of the machines on that cluster now, one acting as
>> NFS server from an ext4 mount, the other is the same client as before.
>> That way I managed to capture a trace and ibdump of an entire cycle:
>> mount + successful copy + 5 minutes later a copy that got stuck
>>=20
>> Next to no noise happened during those traces, you can find them attache=
d.
>>=20
>> Another observation made due to this: unmount and re-mounting the NFS
>> share also gets it back into working condition for a while, no reboot
>> necessary.
>> During this trace, I got "lucky", and after just 5 minutes of waiting,
>> it got stuck.
>>=20
>> Before that, I had a run of mount + trying to copy every 5 minutes where
>> it ran for 45 minutes without getting stuck. At which point I decided to
>> remount once more.
>=20
> Timo, thank you for gathering the debug info.
>=20
> Chuck, I need your help. Why would the server lose a callback channel?
>=20
>           <...>-1461944 [001] 2076465.200151: rpc_request:
> task:57752@6 nfs4_cbv1 CB_OFFLOAD (async)
>           <...>-1461944 [001] 2076465.200151: rpc_task_run_action:
> task:57752@6 flags=3DASYNC|DYNAMIC|SOFT|NOCONNECT
> runstate=3DRUNNING|ACTIVE status=3D0 action=3Dcall_reserve
>           <...>-1461944 [001] 2076465.200154: xprt_reserve:
> task:57752@6 xid=3D0x00a0aaf9
>           <...>-1461944 [001] 2076465.200155: rpc_task_run_action:
> task:57752@6 flags=3DASYNC|DYNAMIC|SOFT|NOCONNECT
> runstate=3DRUNNING|ACTIVE status=3D0 action=3Dcall_reserveresult
>           <...>-1461944 [001] 2076465.200156: rpc_task_run_action:
> task:57752@6 flags=3DASYNC|DYNAMIC|SOFT|NOCONNECT
> runstate=3DRUNNING|ACTIVE status=3D0 action=3Dcall_refresh
>           <...>-1461944 [001] 2076465.200163: rpc_task_run_action:
> task:57752@6 flags=3DASYNC|DYNAMIC|SOFT|NOCONNECT
> runstate=3DRUNNING|ACTIVE status=3D0 action=3Dcall_refreshresult
>           <...>-1461944 [001] 2076465.200163: rpc_task_run_action:
> task:57752@6 flags=3DASYNC|DYNAMIC|SOFT|NOCONNECT
> runstate=3DRUNNING|ACTIVE status=3D0 action=3Dcall_allocate
>           <...>-1461944 [001] 2076465.200168: rpc_buf_alloc:
> task:57752@6 callsize=3D548 recvsize=3D104 status=3D0
>           <...>-1461944 [001] 2076465.200168: rpc_task_run_action:
> task:57752@6 flags=3DASYNC|DYNAMIC|SOFT|NOCONNECT
> runstate=3DRUNNING|ACTIVE status=3D0 action=3Dcall_encode
>           <...>-1461944 [001] 2076465.200173: rpc_task_run_action:
> task:57752@6 flags=3DASYNC|DYNAMIC|SOFT|NOCONNECT
> runstate=3DRUNNING|ACTIVE|NEED_XMIT|NEED_RECV status=3D0
> action=3Dcall_connect
>           <...>-1461944 [001] 2076465.200174: rpc_call_rpcerror:
> task:57752@6 tk_status=3D-107 rpc_status=3D-107
>           <...>-1461944 [001] 2076465.200174: rpc_task_run_action:
> task:57752@6 flags=3DASYNC|DYNAMIC|SOFT|NOCONNECT
> runstate=3DRUNNING|ACTIVE|NEED_XMIT|NEED_RECV status=3D-107
> action=3Drpc_exit_task
>=20
> It's reporting ENOTCON. I'm not really sure if this is related to copy
> offload but more perhaps doing callbacks over RDMA/IB.

If the client is awaiting a COPY notification callback, I can see why
a lost CB channel would cause the client to wait indefinitely.

The copy mechanism has to deal with this contingency... Perhaps the
server could force a disconnect so that the client and server have an
opportunity to re-establish the callback channel. <shrug>

In any event, the trace log above shows nothing more than "hey, it's
not working." Are there any rpcrdma trace events we can look at to
determine why the backchannel is getting lost?


--
Chuck Lever



