Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFD912FBBEC
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Jan 2021 17:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391250AbhASQEC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 19 Jan 2021 11:04:02 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:44216 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391647AbhASP6J (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 19 Jan 2021 10:58:09 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10JFuToU009120;
        Tue, 19 Jan 2021 15:57:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=nx3KseaAjaxcjIA+InLAl+mTZtY8rCMkauW/PRarCrQ=;
 b=DXBFbK/p01vqD+9rn5j0Xh8NmOPgTQjTnsesMeHM4c639tsCYOUtzCX4JsjBh0mbrBY5
 nMYyTfJdOHvy/U0egLoH5NVos6BNfzCnSEl8ZAMaHDhDnVxP4/gzCMy6CK2CLYkEiIOT
 Plek7Lsq5QqePOn0EOaw209vbbAUEFJTHbr8Dt2i+c3IVi0jCLH/dAhO22UXNSsDQeJN
 wioAmrr8bK9Dn2t8w0dEyxZX7VhmUsfC/ZY0OuZaj0DWHdNSUgHSNJ+BeIrGNH2adHHc
 oC6XuEdLBmUyEtvMnQD5RN/qCU/sMGoPn95os7Rv4noam6NWcc6qXCSE0+9w4KguaF+M dA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 363nnahx7m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jan 2021 15:57:21 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10JFafA7193498;
        Tue, 19 Jan 2021 15:55:21 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by userp3020.oracle.com with ESMTP id 3661khcc76-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jan 2021 15:55:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bRNzwOE5/RkTLnW0PjwVeCii9WuNZKi5rQbDL3hpFh3L1j9J0qSwoRB8AzxHo3oUhzO0OpOolXk+8+gG7A8bjZYL1DfPW/DFfalFQNentnp1NH0wjh87QCkaBXyXbl+JiWgqKzwzCqSR63Zf01KGhZbAR9LkVcf5+sCCeWw5epiHR2TGwWRq7vDSIsuLt8rCMwsP0Dw+mtH5YEOwul475g0yubc0DiiZusHgxcXQ21JSYgYpQlbT+RBn7ZxrIl8j56D9837YZGpn+JYv7/fOTqsK4FKv4Rqr+/GJGxWhkrpSQW9tE5GKcWE85ZJDdKz4jm4M4DZ4Nw15upBuoYZCDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nx3KseaAjaxcjIA+InLAl+mTZtY8rCMkauW/PRarCrQ=;
 b=BK32L/O+sRvV9u5VRaR8/hfdLAOWJCpv0boxSDx9ivHcDVRDRrs/4b1RfwzUhEfvq0QelvbnYOtVle+qZSZ1ymS6C4IFcx4ZTUGiya7UflB1wYPWest/wUK5crdm9bFhyleYadhHpnlk2yb4J9f/iHv8yWWY5JcHsvOGvgLxo7uBFT2jMDrddP7aal9DbFr4OPfbjrc8yAjCEDbNn8zJjuuXZcxifA4v2TP/7kGwsAKD8tNUpq98ISo1Jq2iYnAngtTR2M2ObbYxCAteiRVOy+BHHZ6h3IpJZKZmSmOyRtvzTWphwoHSJh+G4k3g5Yzfp/y3gnKW80T1WIO1Yv7AVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nx3KseaAjaxcjIA+InLAl+mTZtY8rCMkauW/PRarCrQ=;
 b=Ti+giCHQUcnFAx6a2Tcsmlpv+W79B14EgNO7frEmGrbv/vTh9oOWaNPVgwVvaiU8XwZOAtd3Y4JKCQWAuwjKuO1Dmq1cvfzChqHdOmg2A38Ss5jQ+8wtVOjcbnMiBgkLvlM9gurxdeqp9Y6ItpD+PUJysfhCyYZi2DcWyr+ct30=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB2920.namprd10.prod.outlook.com (2603:10b6:a03:8f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.14; Tue, 19 Jan
 2021 15:55:18 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3763.014; Tue, 19 Jan 2021
 15:55:18 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Olga Kornievskaia <aglo@umich.edu>,
        Anna Schumaker <schumaker.anna@gmail.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [RFC PATCH 0/7] SUNRPC: Create sysfs files for changing IP
Thread-Topic: [RFC PATCH 0/7] SUNRPC: Create sysfs files for changing IP
Thread-Index: AQHW7nt7AQ6ZiPdlo0OD3oTA8gSlCg==
Date:   Tue, 19 Jan 2021 15:55:18 +0000
Message-ID: <1C4287BD-6772-47A9-B5C4-054CC99C7E05@oracle.com>
References: <20210111214143.553479-1-Anna.Schumaker@Netapp.com>
 <CE510EA5-1E3F-4516-A948-10A0FF31C94F@oracle.com>
 <20210112165911.GH9248@fieldses.org>
 <CAFX2JfmYrCSYfCCGgQ0eghU3WSqk=T38wxkJ7Q42ORw-NFeFQg@mail.gmail.com>
 <7003D8A9-3B95-4B36-84EC-99D4D1806366@oracle.com>
 <5EBDAA40-4F55-4EF2-956D-9877C4F4A9A7@oracle.com>
 <CAN-5tyF=qQbmBPXY7HDAEReidYYqFsV-dFrtkqqJfRAsxtyu8A@mail.gmail.com>
In-Reply-To: <CAN-5tyF=qQbmBPXY7HDAEReidYYqFsV-dFrtkqqJfRAsxtyu8A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: umich.edu; dkim=none (message not signed)
 header.d=none;umich.edu; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 94edf8ed-0329-457d-ecae-08d8bc929edd
x-ms-traffictypediagnostic: BYAPR10MB2920:
x-microsoft-antispam-prvs: <BYAPR10MB2920F8BF7A5E697749CC78A793A30@BYAPR10MB2920.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KUiaSHRGm5KeHauK4i2Js3P3GcwmdJSYmZDbdkROnMXE0DPfKvtwBuRc2EaTT9zWNhbtAV29hlQFb8MldaQQPjWgrvswluW2XtAOnpkqWXeSJHmsZHROSTxDprBdB2mlqZAvyY4c7bnipLmqnJpYDkSadGI8uN2amMfkMTTp4yKK8+iuLQcVYBgxqXRsyiJhmC0B5NAaMJASU4ADIr3x68JsRz4ogtFjRjvJnVKmOiTIDT1yUq+k0rCPGj25uZeOqu4+Pl0ix1bbKrRxfprxo5tSGgGv0Npx0HJKo48jdjivNmbueqKPm8QGOjz1E0YK6cx32Nt9Z3CCB8BT5F2SrWy5VfhWGwPBfLrDpIriVsGkT9SNM5ultZ+9ClWlpQP1D7tTB/vUqye/hSSEWg5HCctpX+ZZlmZx2xX4nWQtFcMpiXZHFdRfOSwp7b+GVnJC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(71200400001)(8676002)(4326008)(44832011)(2906002)(6486002)(86362001)(6512007)(2616005)(186003)(110136005)(66946007)(66446008)(5660300002)(498600001)(64756008)(66556008)(66476007)(76116006)(36756003)(33656002)(91956017)(53546011)(26005)(83380400001)(6506007)(8936002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?MvCadoSA4ReFfqAVvAGNBnKHRY5Q21wfyToJHoa7AigIxXlm4BhX2uvHI3XF?=
 =?us-ascii?Q?W2j3hxatfAC6Ja9IZ/c9wGnDUGIKrPuaxaryG5xKPfMzDUm3t8DXZLwSkzvh?=
 =?us-ascii?Q?IQ3WFVKyKyu1GSFLsQX+rmZoejZ6QThe6X3+pMMJryBlbI5J7aWnLeApjtRY?=
 =?us-ascii?Q?elzXKml4g0HD03Roo30oxr9B8JdbahnrRr9I4WGdHBFrFkno9k1Qn4+jLd9k?=
 =?us-ascii?Q?JA1xIGK4kwovKu8VsRR87We07sDi3Kn4ki9cxiU3vi3fnPC+cLunJfu+Wt3j?=
 =?us-ascii?Q?2OXkBuZZjeauf+8fnPvFLRN6Gt/FF0ELXGjMJLoS52zEhHNbeQw3sTatUlp5?=
 =?us-ascii?Q?+fQqmN8HavTThiNr66VIh4sTSB4OFxXnk06uP/CiRMNGQbi/x223XnrQikuG?=
 =?us-ascii?Q?7JU71vg/B142Szpo6h7lfnLwwFOE+UrVEU73D1W4anq4Wiphx/ZjfAhzfN6t?=
 =?us-ascii?Q?HG9rMNxXT3ZmA9KgwHneYDXNvE03mu/UBic3DGtDqm2h6YcclrlD03xKeekG?=
 =?us-ascii?Q?B594FDuQaaSCdkP5/V9/hsjVZLkADViunGJ5uypHeOTTNeOGK5G8kWiOMZXg?=
 =?us-ascii?Q?JNr8aZeLojjbJoVf1hmIlh+0yWlDS6oo3ohk7Va+/WS5cG+3Ibuoa+QlVvY3?=
 =?us-ascii?Q?MzqEx3GWMla4ewc3cL/JPYZDT/buZlqvsCMneb2GZx9A/LESE/vuZwZZjN+R?=
 =?us-ascii?Q?x1HvczfRkkxO0raJH3xmx/ejtQ84u25qm0NUpaWSIgdeABJw4HLBkNhHlYy3?=
 =?us-ascii?Q?20PANxzNxs7riklW3+Ud3RNKIXA6EDqJv8/l691CHL3yX0ewQfPEgnSxwyE0?=
 =?us-ascii?Q?5aWoCKmZNB7nduQVI2pH2rSm/L+w5rQBG6X91BiPjOn0looe5CZZlBZdl7B3?=
 =?us-ascii?Q?d3mPMAH3e3EbrCYIeoe808cIa2u6UQTW9bm+t+qLV9lp4HnO9dzkouRypZjc?=
 =?us-ascii?Q?lWh7WpQBMG4LfabJYBJnk5vIwjysx3gl3twbQwPvF5sAeHTQNrfkfXw20Yd6?=
 =?us-ascii?Q?uy2Q?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DFA17299CF599C41BCE810B640BB1CA6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94edf8ed-0329-457d-ecae-08d8bc929edd
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2021 15:55:18.8809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uRMR/tP6ty7s2XvV9wQASIuEVqHXSwpaEkyMayUDH9I4gcFHZ5tFCPTNAwfhTPSJynjRZHPQHOxqO9v8PkctRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2920
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9868 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 phishscore=0 mlxscore=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101190094
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9869 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 spamscore=0
 mlxlogscore=999 clxscore=1015 bulkscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 mlxscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101190094
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 14, 2021, at 3:29 PM, Olga Kornievskaia <aglo@umich.edu> wrote:
>=20
> On Wed, Jan 13, 2021 at 9:18 PM Chuck Lever <chuck.lever@oracle.com> wrot=
e:
>>=20
>>=20
>>> On Jan 13, 2021, at 2:48 PM, Chuck Lever <chuck.lever@oracle.com> wrote=
:
>>>=20
>>>> On Jan 13, 2021, at 2:23 PM, Anna Schumaker <schumaker.anna@gmail.com>=
 wrote:
>>>>=20
>>>> On Tue, Jan 12, 2021 at 11:59 AM J. Bruce Fields <bfields@fieldses.org=
> wrote:
>>>>>=20
>>>>> On Tue, Jan 12, 2021 at 08:09:09AM -0500, Chuck Lever wrote:
>>>>>> Hi Anna-
>>>>>>=20
>>>>>>> On Jan 11, 2021, at 4:41 PM, schumaker.anna@gmail.com wrote:
>>>>>>>=20
>>>>>>> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
>>>>>>>=20
>>>>>>> It's possible for an NFS server to go down but come back up with a
>>>>>>> different IP address. These patches provide a way for administrator=
s to
>>>>>>> handle this issue by providing a new IP address for xprt sockets to
>>>>>>> connect to.
>>>>>>>=20
>>>>>>> This is a first draft of the code, so any thoughts or suggestions w=
ould
>>>>>>> be greatly appreciated!
>>>>>>=20
>>>>>> One implementation question, one future question.
>>>>>>=20
>>>>>> Would /sys/kernel/net be a little better? or /sys/kernel/sunrpc ?
>>>>=20
>>>> Possibly! I was trying to match /sys/fs/nfs, but I can definitely
>>>> change this if another location is better.
>>>=20
>>> Ah... since this is a supplement to the mount() interface, maybe
>>> placing this new API under /sys/fs/nfs/ might make some sense.
>>=20
>> Or you could implement it with "-o remount,addr=3Dnew-address".
>=20
> A change of address is currently not allowed by the NFS because
> multiple mounts might be sharing a superblock and change of one
> mount's option would not be correct. The way things work from this new
> mechanism is system wide and all mounts are affected.

OK, well, if we're going with an API based on /sys that shows
underlying transport connections, is there a way to expose
whether the connection is established or closed? Maybe also
last traffic or last connect attempt?

Can it support RPC/RDMA connections too?


--
Chuck Lever



