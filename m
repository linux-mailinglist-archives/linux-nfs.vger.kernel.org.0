Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 967E94D9CEE
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Mar 2022 15:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbiCOODw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Mar 2022 10:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244284AbiCOODe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 15 Mar 2022 10:03:34 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5C6546A4
        for <linux-nfs@vger.kernel.org>; Tue, 15 Mar 2022 07:02:15 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22FD59Yr029144;
        Tue, 15 Mar 2022 14:02:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=/mjX2EG/Kk+gwm2k50b/GWDRXKva0XU1QfZ/pi3RENM=;
 b=EAzrpv7k406TLUlfm4ZoUiytmQyiiP5+IRd3WIIgf4BApnu1TBJY/KYzQN4tRgE2IGIu
 lZ6vs2aRinpwTDYNS0vTWIAXhemR/4Sw7TmdfUd+n9Tb3DqMXuSMVuexw3hMKfBqwZTs
 oK/IGJLFuPKOToiG9cKRWuwFZ2IilxPRJ3sogdE0BDJy3c5ZYq61OkqwL3p6E0b9+Mrm
 wpnzZuNYn7FWJruuLOjKIkzeILE7qyChZX8svsSYwRZvxTW4XtXLsYc8Ds40Srew88Jv
 rdAtgj7+HAM4NyJ408iXZgcrhqK4GlRDiHdEjjZvX49AkPw/IFOTSR5+iUvRyjB4CtLZ qw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et5xwk42v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 14:02:01 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22FE20L0045842;
        Tue, 15 Mar 2022 14:02:00 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2041.outbound.protection.outlook.com [104.47.56.41])
        by aserp3020.oracle.com with ESMTP id 3et64jywsg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 14:01:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O1Hzv8RuMzRYlQ0c52xTizeWIswThEn069ST54DhAOHx7mJOzze4p83UR1IOOf+pqWWngN/Mj5hvhWQYzcndJ1r5QBeclmYZHVywRH6MJ/8BK/RSjIOuMRF7/fdLZyC8FksOgo53MDisHrwWQ4BXIHbFkukEnlNvpNAczjBHNmIYYPmI+40IvIckiYjgab0fi+Tpv6TEPVSq1rANy8pxb7NlhqDO+cUAQh3A400IQOeq8nk8vfcd2KgoPPD6MPMVS0fLcVPXndkHFdjMLtB8lXYgwlqeWd+lEqmJR5OK/1bC80j8w3+Exl4unp6StrOQSBI7W1Nnie7Mua7SNewcSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/mjX2EG/Kk+gwm2k50b/GWDRXKva0XU1QfZ/pi3RENM=;
 b=W+QXbJMTEAJMh4UIBLGH5dePJNS6a17pf8tXhIpQ1mb1eTS2WIyoOmWWjLkWP/rqpszd5BpPf5EzH2IpS1V2Ax+40xaaIVhThgzNguWcZaEqRN9W8xCUoU2JjOGSspzKoAQBR6HzsyjtL5nqWgBNlUvBdVG2qxfW42VE1vypWF7XqkN73F008qAnBJGbezty8cbHdsuouN7/89etwCwNxzwT7ZJ8ugG7q0bqr1WO5iGHDlboKbT9W1pTrO4K6ZWanwzxQTQDioJsYLQXUAsKgHQvizcG2zo61UJPhgpw0Z2b7FTar1BsfkrttC2d8mJr5O5IMcnrXMIQuXM0IzM+xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/mjX2EG/Kk+gwm2k50b/GWDRXKva0XU1QfZ/pi3RENM=;
 b=i5d19n5Aihzqkie18PN/hVkLb6AbiRwkt2Y4RPuIyTUoe2zqR2yK5BG6rq8X1aCOaGF0noqzPHOvRtqAqntxAXF5Mye1OItrpdGZH+2v/XHtNbVUEw5h2ui2XtWNM5CVT8rCha+zBp03mj9GwD94SR1xlyNXS/OtiqVma22XO8w=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5168.namprd10.prod.outlook.com (2603:10b6:5:3a0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Tue, 15 Mar
 2022 14:01:53 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::94c5:42b1:5147:b6f0]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::94c5:42b1:5147:b6f0%5]) with mapi id 15.20.5061.028; Tue, 15 Mar 2022
 14:01:53 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: write_space and software kTLS
Thread-Topic: write_space and software kTLS
Thread-Index: AQHYN+t2c9NNn2vvyUmVc3p8QXQTC6y/kR4AgADpe4A=
Date:   Tue, 15 Mar 2022 14:01:52 +0000
Message-ID: <624F8B1A-7233-4DE6-A383-A17D88D3BB2F@oracle.com>
References: <B7F08FCD-0EC1-4D7E-A560-6ADA281605AE@oracle.com>
 <378c5635b97c237f869234e24030ac0018b684b3.camel@hammerspace.com>
In-Reply-To: <378c5635b97c237f869234e24030ac0018b684b3.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2650f7cc-105f-4f9a-b52b-08da068c5bbd
x-ms-traffictypediagnostic: DS7PR10MB5168:EE_
x-microsoft-antispam-prvs: <DS7PR10MB51687D55AC466419EA03895293109@DS7PR10MB5168.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o4+yLaR33CMx4x7T7+fNebCL7cE2AYJiznQkvmPmr03TJkOnETLhV4suptYN3ELxCFGG32UR9iT4+nWxYT97zqrXuobBO55API4/llqoGfDDtdyuy0n6apsdBeWt3Jrclh53iUia4xIbIi/x2jS8KOvfIlMeuIQJ4hUFl1UKtOayLBqkxt6iJdbiURjsD1v+TityDF3IcywGk0G1qIxaLe5D2lzQs7MmmPy+sbNAg/x4/SuDhpL4JCZUI9bq0fQE4UIHlnV1kyq03XCeS5Y0qMc/+8iuSQQ/fU1TiUcOUGczpsuV/oXnv6J+UTReYGgxHf/6f/R8U1yCAQOLrx6M2b1uTAMW6fqMomQ0OocVq7VW6HrfNoKSHfWMZlNeLhiIXbaxVBC9nk5F2dXv7donaKSRNHpJTS5xIcLznezP9oBabXbJP8E6iJcaoN2eQfGbRilhvQ+zIr5HNVQ7TGFQuO07NxZQMvbdRRfy1PEBqUPTKPwYEIgmBHiNv9sQZWPAF/wl7iGeHMXRvBisFVq2VnkdYfQGIb4IhyhTWLHHmCAYU/kPk2EwEPcnB/54g3OT+k0l1HEhLgzYQ1zEuQdRmJ2PJBpNAyQ133D1/PT0ztgTKPeUfPL8tvFyx7QpFTN+piSthimwowXH8CdffO8snfCbWXYgZBG7CYNkwtBm2EiSGuz3Umw7tKF58rV4omAP2NwLem0wSp3X2Sx+mWI40017ZwcZUuqlPlmWlj0zJ6iOIPPzv+Ajc0uGD9fPt/za
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(4326008)(66946007)(66556008)(66476007)(66446008)(76116006)(64756008)(36756003)(91956017)(2616005)(186003)(26005)(2906002)(316002)(6916009)(38100700002)(83380400001)(38070700005)(53546011)(6512007)(71200400001)(86362001)(6506007)(508600001)(5660300002)(6486002)(8936002)(122000001)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GPBoX8DbYzwOLoSoNZGTYpUQSxTlwTo0NK2yVUaLx+QUQCXcKw0HhEgfkJKg?=
 =?us-ascii?Q?C9fbFu9mQ+1EmSPpePjd1naftgeWC5Ty8h6fxtgtLSd570Cje2iJK7r8vdJo?=
 =?us-ascii?Q?w6omJVYfUSzgsykQCWX1xcYJnTjbNkA9Ro/KM20jTWt3O6Iox4AjilCbTGvt?=
 =?us-ascii?Q?TzFql14R/B7DC4pZ/wmd27+aWO9YLXDLg/0z9fxeHdeHYUp2ocbGlp2vBlRT?=
 =?us-ascii?Q?pTDQfqC7NHYhS9Q6kR18keoucWTwMSUF0D2uu9WWFuunbDCCtcZHdfsfFqDl?=
 =?us-ascii?Q?KUc9rbp5xZ7tUu5R/ZzqLTzz/QsrW6zAeGvvrogXf+ssl1ldJpqlMVs+5e5F?=
 =?us-ascii?Q?pPn09CmnevlcGC5kd4mDgsCYTH6qJWISrwJge5ZIl4Gr2CPjNiwu44l9M0sI?=
 =?us-ascii?Q?GKf6BKmgEm+mUKtG+twas6R7WWMXMjrlAqWMk7gpCZlv6P7X9FeC6EDjeWYd?=
 =?us-ascii?Q?hGafTFZOOKXgIqdBlcLrBhdSvUncJp5k1m27NlVJpngvC2Q9hYpQBQ/ILZiy?=
 =?us-ascii?Q?peCeAdeGtynbERhNgkyM/CaUKcD+dVVLMqnwbJQbLwdiG9Lsp3e6odtc9GC2?=
 =?us-ascii?Q?gu75LpOEHCh8jEzqo3CIDHxOLOH7nMzoR5kFjuPbKYVYPJFBZlqQQDYnYb95?=
 =?us-ascii?Q?ApJML6lS4cUjAe7PfPfZkjAyTwLBr59Jhy2bxs1h5zhN4SKjy0B2G3kpgtA5?=
 =?us-ascii?Q?cZmRTz5S0KfEe339r2Es32/ptUkbehYjW43SSrzKldVAgWcw02ppLpbcLANZ?=
 =?us-ascii?Q?Woa1eH2UOWMKzGnGcDSXlACi3kBMSuQo8PQtrpIyqrTXWbsCWqwoJLqyrMah?=
 =?us-ascii?Q?RKo3ZU5o4OM8DwGgy0Ksq0Ncgf8CBopmnzT4txsxqARGo/nE8hjc+K5hVcwm?=
 =?us-ascii?Q?0SD5SqS3P57r6dKMyF0n3LtfSeEGrkaN9aprzq6qgaQwKUi0G3L9/oNDjp4D?=
 =?us-ascii?Q?IZ4jgZIIwvgNSdcRrU8BgXffx/IZh169hK+iCN2Mp4+D8X3nSq2G9TjmH0EH?=
 =?us-ascii?Q?iLF7P9Fx6MXvVJe/ty3CcokWxU9nxrL4AzAIqwXx8B4y97aH8AOGZrvNzTl9?=
 =?us-ascii?Q?mlm83EVOdTElEQ17GD7dcfaj4lTniy40+qx6gT3NQGUHX+Dsr13DkgpMKa3g?=
 =?us-ascii?Q?pyeKXMa11AIkYZ+Wq36iAI8DWSByc0roCCqXn46/vhQq/V+sb1Yn9w5l4/gZ?=
 =?us-ascii?Q?PmP4FqOck4iKgBPEK6VaH3JDoJQxWq2qs7oa1/tzak10zMnOdlAGEeL8F2Sm?=
 =?us-ascii?Q?uSIxbET+rO9jGNOoNqhRpaBJI9s/zfH5WSthU2fR2ozJ86EJK/UJLU3UJwVa?=
 =?us-ascii?Q?m8X0x6j8iE1jxLsMuJIOAl0QDeKsUl2mHr/qJ95EvMI4GG/92M/lFrn3X74c?=
 =?us-ascii?Q?QrJnv9ZCl6RxRkif7qBWZ27OjlnxUj89nkdMQpVnLrwvp5bWDE3nL2CFNMj/?=
 =?us-ascii?Q?lcKUfOr2Z0paqCcunxTJpQCi8KbVj7fdXDcRGyNjU2FiuyaMUiKkOQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E1593DAF8BCB9B43AEE5AEA5E0C82F06@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2650f7cc-105f-4f9a-b52b-08da068c5bbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 14:01:52.9912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8wFrAZIAafyXnaMLve7Hf+d5SNbS1YCfvIRqE6Tr/JbbO3QFSnFkQo4B0BgnCK5bwiW6q1zLOj/gwxe9OUwXRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5168
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10286 signatures=693139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203150092
X-Proofpoint-GUID: oXqDfPOubJ_ClRohfIFCJIKUFq54abV1
X-Proofpoint-ORIG-GUID: oXqDfPOubJ_ClRohfIFCJIKUFq54abV1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Mar 14, 2022, at 8:06 PM, Trond Myklebust <trondmy@hammerspace.com> wr=
ote:
>=20
> On Mon, 2022-03-14 at 21:35 +0000, Chuck Lever III wrote:
>> Hey Trond-
>>=20
>> I've made some progress getting RPC-with-TLS working in
>> the Linux NFS client, but I recently hit an interesting
>> snag and could use a little advice.
>>=20
>> The software kTLS infrastructure uses do_tcp_sendpages()
>> under the covers, and that function is clearing
>> SOCKWQ_ASYNC_NOSPACE from under xs_nospace(). That
>> prevents xs_run_error_worker() from waking up xprt->sending,
>> stalling an RPC transport waiting for more socket write
>> space. I'm not sure how to address this, and I'm interested
>> in your opinion.
>>=20
>=20
> How is it achieving this? We only set SOCKWQ_ASYNC_NOSPACE after the
> call to xprt_sock_sendmsg().

A kworker is clearing NOSPACE between the time xs_tcp_send_request()
sets it and the time xs_write_space() runs.

  kworker/u128:2-33    [003]   155.723869: rpc_socket_nospace:   task:00000=
6cb@00000003 total=3D262380 remaining=3D131308
  kworker/u128:2-33    [003]   155.723870: bprint:               xs_nospace=
: sk=3D0xffff88810a8f0a00 setting SOCKWQ_ASYNC_NOSPACE
  kworker/u128:2-33    [003]   155.723879: xprt_transmit:        task:00000=
6cb@00000003 xid=3D0x8ab69e2e seqno=3D0 status=3D-11
  kworker/u128:2-33    [003]   155.723881: xprt_release_xprt:    task:00000=
6cc@00000003 snd_task:ffffffff
     kworker/3:2-116   [003]   155.723885: bprint:               do_tcp_sen=
dpages: sk=3D0xffff88810a8f0a00 clearing SOCKWQ_ASYNC_NOSPACE
  kworker/u128:2-33    [003]   155.723888: rpc_task_run_action:  task:00000=
6cc@00000003 flags=3DASYNC|MOVEABLE|NORTO|CRED_NOREF runstate=3DRUNNING|ACT=
IVE|NEED_XMIT|NEED_RECV status=3D-11 action=3Dcall_transmit_status
  kworker/u128:2-33    [003]   155.723889: rpc_task_run_action:  task:00000=
6cc@00000003 flags=3DASYNC|MOVEABLE|NORTO|CRED_NOREF runstate=3DRUNNING|ACT=
IVE|NEED_XMIT|NEED_RECV status=3D0 action=3Dcall_transmit
  kworker/u128:2-33    [003]   155.723890: rpc_task_sleep:       task:00000=
6cc@00000003 flags=3DASYNC|MOVEABLE|NORTO|CRED_NOREF runstate=3DRUNNING|ACT=
IVE|NEED_XMIT|NEED_RECV status=3D-11 timeout=3D0 queue=3Dxprt_sending
     kworker/1:2-115   [001]   155.733398: bprint:               do_tcp_sen=
dpages: sk=3D0xffff88810a8f0a00 clearing SOCKWQ_ASYNC_NOSPACE
     kworker/1:2-115   [001]   155.733418: bprint:               do_tcp_sen=
dpages: sk=3D0xffff88810a8f0a00 clearing SOCKWQ_ASYNC_NOSPACE
         openvpn-914   [001]   155.750263: bprint:               xs_write_s=
pace: sk=3D0xffff88810a8f0a00 SOCKWQ_ASYNC_NOSPACE was clear


>> For example, why check that flag rather than just waking
>> up xprt->sending unconditionally?
>=20
> The socket code calls ->write_space() in all sorts of situations, so we
> need to distinguish between the cases where we are actually waiting for
> buffer memory, and the situations where we are not. Otherwise, we'd be
> calling xs_run_error_worker() all the time.

On my (admittedly limited) workloads, sk_stream_is_writeable()
does a good job of avoiding spurious wake-ups. However, to be
absolutely certain of our wake-up accounting, using a flag that
is local to the rpc_xprt and not overloaded might be wise?


--
Chuck Lever



