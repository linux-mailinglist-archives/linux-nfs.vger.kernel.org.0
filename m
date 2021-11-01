Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA03441CC4
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Nov 2021 15:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbhKAOm5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Nov 2021 10:42:57 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:20446 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229826AbhKAOm4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 1 Nov 2021 10:42:56 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A1DKOGk006687;
        Mon, 1 Nov 2021 14:40:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=+kSfPii/Fa4dxcfZ4TWokViSuw1N/dMB+D8SxQ12Eio=;
 b=iO8RpJZQiDB0ULa7w1xGujpe8mGJtloCuBx+Fn+uUCHWU9z5O9THwR8AVJM2W7Ni3vtM
 TMOeSkwxN8NxPMPQbmGsWo7Y4uxIrlEN0WLupRK//FPhVMTjDd6Z08DnkmSMX0XuMeVb
 mA6/+7AVw6HKt8V85thqMcSCn5q/QoubXDfrZ6TdF/yb7CgdqFdlGXw9zepZo4P6HA+R
 k2Co0E8x1to/g9wgYYKwz8cpXXLnPP2Rv1VKOBktowsl1l20D7Ygh96eLTFp3IYO15Xf
 cnP8LX5T50U1phl+Vf+19tq5lKLLCsBJq8afnsn/82UtFge8MSYf420873GCCptlHfoH WQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c290gt2vd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Nov 2021 14:40:16 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A1EdoXH171817;
        Mon, 1 Nov 2021 14:40:16 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by aserp3020.oracle.com with ESMTP id 3c0wv2vb97-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Nov 2021 14:40:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XCc8z5RlFbbPNg39PILDDplL3U7JLzgXewNk+ObWpCRqqPzZjfIcmjmHZhFxBjJG2G4nwO2SRjrrIl7n4Fdl9k0XW5Qc9KZt6mwtYXtm4apa8WiJ8t1pDQwGRTBNPrGYJG8PNlIaNRAfqAucvf1MTbdPOQS/uhcDu8D0E4U79YoR5KrxnWE72qKGTs11UApRTzbPWEL4FTSDEdNucQ94hHtLRUKb2mlMu3QPJRUL6VJ4YfYaapXXDw+N+b4Vw/WPvx7lgKVREZKUqG3Mmrwd1z1SP/PQbCtHO3OYZgpjKjJsaOzigCBNXXU54TzPXU1iIq4hTqWvegxBGe9CTYzpsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+kSfPii/Fa4dxcfZ4TWokViSuw1N/dMB+D8SxQ12Eio=;
 b=QxDAaH5NtpakSc2BGyIAQCyNJBJIjjbq4XrFU7s5zJS/tmPpWhO2FDrfadjZBQjv/VV+9rfVwzvrHPBrzY5BNQxnJjA5nV+s1lQtvgo0Ki67+g+KC+vpJhh53pJEdqoNF9PKdIxMK/KXJDv5Y7HuiOshLd+Xqp0gEhRePIVL9UqEe3fA83p1d+jZ5IR7h7U7krHskSmMww+81hwqB4d7sigyHI/t1x0fxygrrpnV94nVTW95NWpW7RQJCd/ZGTN1GidkIqfnD5mgD+Sxi2rd6KsXh8yl7hV97z+sWBXmYyFwXMx9Q5qXKvfl1HSMicIej9vHjR4eQWFDyQsT2/+J2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+kSfPii/Fa4dxcfZ4TWokViSuw1N/dMB+D8SxQ12Eio=;
 b=cpuzRlzVYnlpeSeLeFPaTZ+5vAw+e/hvQifxBkCMW6CO8dyawQ0VfoaoaEHk+iydM4q9YLWMJH+lEPkyXC6BpvcebuPSBoP66u14DxCB5fy4EhwDBSUmmjQ89MxJRz9MKZv7f2BpNJSfIBHiMg5zYgWrRjyyEL9K9SaX5kWbGO4=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB3859.namprd10.prod.outlook.com (2603:10b6:a03:1b6::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Mon, 1 Nov
 2021 14:40:12 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::2ded:9640:8225:8200]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::2ded:9640:8225:8200%5]) with mapi id 15.20.4649.019; Mon, 1 Nov 2021
 14:40:12 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Anna Schumaker <schumaker.anna@gmail.com>
CC:     Steve Dickson <steved@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
Subject: Re: [PATCH v5 0/9]  Add a tool for using the new sysfs files
Thread-Topic: [PATCH v5 0/9]  Add a tool for using the new sysfs files
Thread-Index: AQHXzCqUh5X9K2vCzkGvU1ZDUvreSqvuxGsA
Date:   Mon, 1 Nov 2021 14:40:12 +0000
Message-ID: <567882BB-751A-4E17-A84E-19A81E1DD6FE@oracle.com>
References: <20211028183519.160772-1-Anna.Schumaker@Netapp.com>
In-Reply-To: <20211028183519.160772-1-Anna.Schumaker@Netapp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e452cf8-5f13-46c4-2b21-08d99d458339
x-ms-traffictypediagnostic: BY5PR10MB3859:
x-microsoft-antispam-prvs: <BY5PR10MB3859EC3AE4CA62BA2C199D54938A9@BY5PR10MB3859.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Opbv36aUIjxR6dvLmwCsC2/S/VnvL03YWtgcoXHxvpxtRNtytDUmbhIqq939xKeb++/FtfVYcIqITTm30tyLP6Te/C0bUYdse72tqAkBaYXQAAhAkuCBcWAD9n+H78BoN49cNRxmfckieGswmAQxKockbdcNUeislkg/AR9vCclUjdSsqy85PxZYaOsu1Jb5CtX7xDA2klDt8oldlVz8NshoJdVSrNU/mkLuCJzbh43rSCbR+YOJqw0/SWhzmeCFQwHHD4yflHXJzbSiZ3SncWwTxS8lXkQulNPm6f8d+tV+oA6V9LYROeDwKYOacX4ApQ7/1FqpvCdSXo5OQaSAn4KHnbVHD22SlMp32QeS007h8Zo3em3WiALRcJRv+P3ULite6sb/Mgm3Za9H6e3meCZk+KyYGW02DpQ7S6uv47jfkxa8CKWylWI1lVv9HBhZ4pmTqg613N4pYgZ0qh9dYOxo2GDJuIS94Xt+vbGfc6r4fKnYHQqmSxN32VUYVTSk/SpVMDXxoxvnH5/jZQu10qDzlh+/sSEpyLUEHk9V8Oxlj/dc6HRFuJ7Z0AtFqpwP+qNwey4vXn63NzNhdN88qIr6WdhqGh86JSLkg2lRHoHROqhVSUD6BUir2bS78nYa658geUNZz8Be0ho37j78Bljr6JYLydRNFYSIMZdbpQOyDzmZcBXSvXLiV2uscfQnYCIrBKsP6tTo0QyFgxIz5/EqvqwN9wM2TbP+4dnLi0peU95Neqc/zXiVi6UJBQXG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38070700005)(122000001)(186003)(86362001)(5660300002)(6506007)(91956017)(26005)(53546011)(4326008)(6486002)(36756003)(38100700002)(76116006)(508600001)(2616005)(2906002)(71200400001)(316002)(66556008)(8936002)(66476007)(6916009)(6512007)(83380400001)(33656002)(66446008)(54906003)(64756008)(66946007)(8676002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xqlbAJHDi9Up6zQcU3bqm4jEktk8ESal6GbUrzaWBoL1Rm3V6Z4DCDo9P6tm?=
 =?us-ascii?Q?oOqEPOnVZKMi++6g7Q9Pm2SXz0HugASmCzxgxNZytHXeMP38TN4gGKrBqfGm?=
 =?us-ascii?Q?2Q/jZ9kuRqL4hqh4K0J9ZX92eJaGhlsF5RjgmUsvB/8JqFHztBABfyW+ccg8?=
 =?us-ascii?Q?lNaZP1AUL0/kmP4X/JpyUw7ms4mIY81aY9ZQ0MatuGc/SFSlYlU0MAjF1CIQ?=
 =?us-ascii?Q?PzKj6sJg0n0T1JAt+dNSEqvSI++FNK5OCDF2QzjCqZEbEmSZXqP7PeV7uFPB?=
 =?us-ascii?Q?PNgIv5WDbSAWalucf8N2M9Eqs/GqWAHxf4yIiKq6RnSMX0KTPZScq98jROJE?=
 =?us-ascii?Q?IkV7a1iYsubcjOrfmuD7JHIdOWwMnkKSnElyKK2cElxnrePVoF6FCjoRNmr1?=
 =?us-ascii?Q?YMlC8rsr+K+tW5w00iuwUKUQnwZ4YA7xvFDaY3G2hFZTnYLW8RPHgMm02qND?=
 =?us-ascii?Q?tovWPYDZ0dvBMAhjSFeaLmx2X6qOFv7eokgaq4n9zik3F3SesPdQ5DbhCWZr?=
 =?us-ascii?Q?uvSuT0/d/zYDRjkb9KOQzmPC7yROTpVnnvPjjERTZtsY7J15nqnOH0OqodPS?=
 =?us-ascii?Q?6CSu6HRs0G6UdyUuxsuPY3yiYgf2Uz2cczMgIdj9w66hEOzd0YUGvA9Up0dj?=
 =?us-ascii?Q?rnIYP5Qz8I80NAputyLgM4AsyeScrtYJwFYqAT/6lu5iL60qcBkzjuygi7p/?=
 =?us-ascii?Q?XVXcX9vmUlCP+nHzbaIZhPP7exGz9szHIUtOr5f4B5L5yUJzs2wUQeWmT9Ki?=
 =?us-ascii?Q?UVoN9etKsS5VUkFpb6eeWgjF5Cs56LS0BIRcxjeK63dHRZO6fX9EVAEM9sVS?=
 =?us-ascii?Q?H27ilGGxdQOPAskl6Jll9A4+WIAuz3YEjV5afonf8UyLTe6Rz4YOAS7yQxbU?=
 =?us-ascii?Q?KdWEWFzHA+RrMaaOsDfQE/ArdY3vALwcotVx4a3YJjbRBZDX92/ncbw1FIqB?=
 =?us-ascii?Q?CY9qJoAxmc6UOLpmQORo1PfJ/nTi1jPI6q9No/v/JsWPtshe7xLRuJsSXPEo?=
 =?us-ascii?Q?YNIwMi+F59OWw6AkexDZQ97kA2NkMoUagFXjSqt6nTImOVLRplH0Nb1SAbOR?=
 =?us-ascii?Q?ilUZx8AxOEspHKa0mU820adaertxY5pRjToVjlUhafS+t7rfO84LZIOuQLe4?=
 =?us-ascii?Q?KTp3e3tRNaEwDYv5RafJpqYTELJ0r9XRizw0KCf+c13HKR4PxWkeTCwmUsGC?=
 =?us-ascii?Q?b2BWw6oiKc/Gd7vaanHFVyxdEH3VDIdyFWnlDJd0e3R9sWtNfFOjgHHyzUkx?=
 =?us-ascii?Q?Be0GAXfZ2E6VtMfhUdgs+NbTkpP3M4958NaQy32+s7JK/8E561G5TkvB2JOb?=
 =?us-ascii?Q?z2RnYEYVkTbGnjgN6YCUoQkjWFSjIHC+SBgD19I28dRp/4VfzQJb71ET3NjU?=
 =?us-ascii?Q?wuVrq8WyrtinmK+BxDkZY14pB9/KOyo0qY4qk04E1Lkn7DaWPeM2TpzI3uoY?=
 =?us-ascii?Q?lBEwtGgQqfueQzEXA9Y2Ea3W3XkPmemLLRET9COtIO6ioznC/SeXux5eVtAl?=
 =?us-ascii?Q?z2uMLdYh0qMmHgXabT1SbBo+X2lJikF2/mX4XjsC3PwwXe78pIhjK6EQOpa3?=
 =?us-ascii?Q?wCx7nQu5K62mt2Pf79jCMq0eutD/WJN6zNlBVZnChCm1orxG4b5f9CtAMV4V?=
 =?us-ascii?Q?aHAVYiaRPvir6RX9Ckrk6wg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D3C6EF50AA27254DA0013B0068F86715@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e452cf8-5f13-46c4-2b21-08d99d458339
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2021 14:40:12.8884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pcFa8LZw0HSZ1+Yu/SsCI6KWFfq0qE2fYCYVCDaaTnmF8USkpDCjEZJDMLbj/vkXw5o1OxW6ZLxx9MU/+Sfc5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3859
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10154 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111010084
X-Proofpoint-GUID: c8-Ox2Yny-lQ6xkmVixrWDGf9Zfvey2P
X-Proofpoint-ORIG-GUID: c8-Ox2Yny-lQ6xkmVixrWDGf9Zfvey2P
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 28, 2021, at 2:35 PM, schumaker.anna@gmail.com wrote:
>=20
> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
>=20
> These patches implement a tool that can be used to read and write the
> sysfs files, with subcommands!
>=20
> The following subcommands are implemented:
> 	rpcctl client
> 	rpcctl switch
> 	rpcctl switch set
> 	rpcctl xprt
> 	rpcctl xprt set
>=20
> So you can print out information about every switch with:
> 	anna@client ~ % rpcctl switch
> 	switch 0: xprts 1, active 1, queue 0
> 		xprt 0: local, /var/run/gssproxy.sock [main]
> 	switch 1: xprts 1, active 1, queue 0
> 		xprt 1: local, /var/run/rpcbind.sock [main]
> 	switch 2: xprts 1, active 1, queue 0
> 		xprt 2: tcp, 192.168.111.1 [main]
> 	switch 3: xprts 4, active 4, queue 0
> 		xprt 3: tcp, 192.168.111.188 [main]
> 		xprt 4: tcp, 192.168.111.188
> 		xprt 5: tcp, 192.168.111.188
> 		xprt 6: tcp, 192.168.111.188
>=20
> And information about each xprt:
> 	anna@client ~ % rpcctl xprt
> 	xprt 0: local, /var/run/gssproxy.sock, port 0, state <CONNECTED,BOUND>, =
main
> 		Source: (einval), port 0, Requests: 2
> 		Congestion: cur 0, win 256, Slots: min 2, max 65536
> 		Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0
> 	xprt 1: local, /var/run/rpcbind.sock, port 0, state <CONNECTED,BOUND>, m=
ain
> 		Source: (einval), port 0, Requests: 2
> 		Congestion: cur 0, win 256, Slots: min 2, max 65536
> 		Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0
> 	xprt 2: tcp, 192.168.111.1, port 2049, state <CONNECTED,BOUND>, main
> 		Source: 192.168.111.222, port 959, Requests: 2
> 		Congestion: cur 0, win 256, Slots: min 2, max 65536
> 		Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0
> 	xprt 3: tcp, 192.168.111.188, port 2049, state <CONNECTED,BOUND>, main
> 		Source: 192.168.111.222, port 921, Requests: 2
> 		Congestion: cur 0, win 256, Slots: min 2, max 65536
> 		Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0
> 	xprt 4: tcp, 192.168.111.188, port 2049, state <CONNECTED,BOUND>
> 		Source: 192.168.111.222, port 726, Requests: 2
> 		Congestion: cur 0, win 256, Slots: min 2, max 65536
> 		Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0
> 	xprt 5: tcp, 192.168.111.188, port 2049, state <CONNECTED,BOUND>
> 		Source: 192.168.111.222, port 671, Requests: 2
> 		Congestion: cur 0, win 256, Slots: min 2, max 65536
> 		Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0
> 	xprt 6: tcp, 192.168.111.188, port 2049, state <CONNECTED,BOUND>
> 		Source: 192.168.111.222, port 934, Requests: 2
> 		Congestion: cur 0, win 256, Slots: min 2, max 65536
> 		Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0
>=20
> You can use the `set` subcommand to change the dstaddr of individual xprt=
s:
> 	anna@client ~ % sudo rpcctl xprt --id 4=20
> 	xprt 4: tcp, 192.168.111.188, port 2049, state <CONNECTED,BOUND>
> 		Source: 192.168.111.222, port 726, Requests: 2
> 		Congestion: cur 0, win 256, Slots: min 2, max 65536
> 		Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0
> 	anna@client ~ % sudo rpcctl xprt set --id 4 --dstaddr server2.nowheycrea=
mery.com
> 	xprt 4: tcp, 192.168.111.186, port 2049, state <CONNECTED,BOUND>
> 		Source: 192.168.111.222, port 726, Requests: 2
> 		Congestion: cur 0, win 256, Slots: min 2, max 65536
> 		Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0
>=20
> Or for changing the dstaddr of all xprts attached to a switch:
> 	anna@client % rpcctl switch --id 3
> 	switch 3: xprts 4, active 4, queue 0
> 		xprt 3: tcp, 192.168.111.188 [main]
> 		xprt 4: tcp, 192.168.111.188
> 		xprt 5: tcp, 192.168.111.188
> 		xprt 6: tcp, 192.168.111.188
> 	anna@client % sudo rpcctl switch set --id 4 --dstaddr server2.nowheycrea=
mery.vm
> 	switch 3: xprts 4, active 4, queue 0
> 		xprt 2: tcp, 192.168.111.186 [main]
> 		xprt 3: tcp, 192.168.111.186
> 		xprt 5: tcp, 192.168.111.186
> 		xprt 6: tcp, 192.168.111.186
>=20
> Changes in v5:
> - Rename from 'rpcctl' to 'rpcctl'
> - Rename subcommands 'xprt-switch" to 'switch' and 'rpc-client' to 'clien=
t'
> - Clean up how the displayed strings are generated
> - Handle kernels that don't yet have the srcaddr patch
>=20
> Thoughts?

LGTM!


> Anna
>=20
>=20
> Anna Schumaker (9):
>  rpcctl: Add a rpcctl.py tool
>  rpcctl: Add a command for printing xprt switch information
>  rpcctl: Add a command for printing individual xprts
>  rpcctl: Add a command for printing rpc client information
>  rpcctl: Add a command for changing xprt dstaddr
>  rpcctl: Add a command for changing xprt switch dstaddrs
>  rpcctl: Add a command for changing xprt state
>  rpcctl: Add a man page
>  rpcctl: Add installation to the Makefile
>=20
> .gitignore               |   2 +
> configure.ac             |   1 +
> tools/Makefile.am        |   2 +-
> tools/rpcctl/Makefile.am |  20 ++++++++
> tools/rpcctl/client.py   |  27 +++++++++++
> tools/rpcctl/rpcctl      |   5 ++
> tools/rpcctl/rpcctl.man  |  88 ++++++++++++++++++++++++++++++++++
> tools/rpcctl/rpcctl.py   |  23 +++++++++
> tools/rpcctl/switch.py   |  51 ++++++++++++++++++++
> tools/rpcctl/sysfs.py    |  42 ++++++++++++++++
> tools/rpcctl/xprt.py     | 101 +++++++++++++++++++++++++++++++++++++++
> 11 files changed, 361 insertions(+), 1 deletion(-)
> create mode 100644 tools/rpcctl/Makefile.am
> create mode 100644 tools/rpcctl/client.py
> create mode 100644 tools/rpcctl/rpcctl
> create mode 100644 tools/rpcctl/rpcctl.man
> create mode 100755 tools/rpcctl/rpcctl.py
> create mode 100644 tools/rpcctl/switch.py
> create mode 100644 tools/rpcctl/sysfs.py
> create mode 100644 tools/rpcctl/xprt.py
>=20
> --=20
> 2.33.1
>=20

--
Chuck Lever



