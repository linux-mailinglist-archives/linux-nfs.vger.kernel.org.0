Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5176D3C6186
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Jul 2021 19:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234561AbhGLRKC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Jul 2021 13:10:02 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:56832 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234187AbhGLRKB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Jul 2021 13:10:01 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16CGv6OO003679;
        Mon, 12 Jul 2021 17:07:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=9daU/sWFtpxrPCLH939in/P+6j4mYMG9zVMU2l3WYaU=;
 b=N8lRD+TFYUfRzvD+yKIF1+VZ3MYWhmw7QaSZc+RE6FyWpqJGPEORq7ImXzn+uwwZccI6
 bp0yI40EfJh0e0Ahbrz92efl6OptH8e979bMYQ64/xQdc430EQDgGatIMy/MXPJP2o0Q
 btovvkegkc3weAHPBgfrhCVtDN2xPJqKrcrmQMNMracP7iy/kXy6HjQkq/J0asFVD/TF
 PgtUr9pqXpVDrEeLf06dqsaQfbQVhtc5ij6epTtInBbTrHCS2ufwp2YS2FSeqziw9Hm7
 piC9Jf7G4QsiqnTIX4bOwVnmLaTXIWKJESlFU8XlBt9ES2AYki65nwntqW1GT7fz0dWq +g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39rqkb0cxk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jul 2021 17:07:11 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16CGt7ro064688;
        Mon, 12 Jul 2021 17:07:10 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by userp3020.oracle.com with ESMTP id 39qnaum7rf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jul 2021 17:07:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cs1VKoEUHSy54QDxWId4h8rb3ygj4AlcB3/D1kaLC4NOh2ULc3cli/6QXFnHlXzfdHWh+j2iz3tRKxsqJnZlwC9T9vDFFqwjtb6PS2YrndTTVZiDC0DmNU46B51fMeZFoKgL+roonTHfVW/jFAyOKcN/Qk1NFBZ3el5a2a/sJGVZDJO3nY/GwtAtaADioIKfObGoBjiyP6EgNX59CztGXIxPytJu3Uxxn4B1/HgbqAfp+fGg0Yl6SUl2U/uMNTxBYZbq+R0L6CfbOf5gt7uBwX/ZaqaoXpqmba99JHc6SSG8B8lRDWhdPk/ugXipGPSxm+eqS7FH3kmki5LxQwLgSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9daU/sWFtpxrPCLH939in/P+6j4mYMG9zVMU2l3WYaU=;
 b=K6wRFt1o3miFmvotHHx3afKDF34fIah5+6hSTCEBWr50NKdeNn7zBqsLj84YAbegJwqXMlu2eKFjY+hWdYAjsYsCNSq0DdqFius440rEkhTMHH9Kp+9Jqv6Yal7B9DUnSzc4AVflROv5bgmE0W4V9TkW/EQ6j1FK8P+VVc76TfIZzAWL4pLOZwP6bFEHJ2CkL5Upi62lCCYGhVE+uaM8Dw9TPC7Ei9Yu7TKHAyx+/JiHrIXVEaQGPnPeUPV87Kc8ZMI/CbuTlvZdelF7ULe65au9cJ7+NK22FcjJJcJ8H6Mxi24snPjQD/fceO7x2jcbTJasQmXjA1VGN0/p4qu2XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9daU/sWFtpxrPCLH939in/P+6j4mYMG9zVMU2l3WYaU=;
 b=ixM3YzhEqgVIgq8DPRh+5QGc5qFK2UjNQBgDvJhmK8qmvtgJYBLcNfUTeIuvHGB8bttKS69SaJXq6YqNBHfv+dsesbuyu04/RZGrUmp4+xrvmp7Q9orh83iJnl6G0vAkr+gYyFxFs8joVzrgd7hU1pQciLIWHJ3PrjKUdil8cYU=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB3860.namprd10.prod.outlook.com (2603:10b6:a03:1fe::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23; Mon, 12 Jul
 2021 17:07:08 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::9dee:998a:9134:5fcb]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::9dee:998a:9134:5fcb%3]) with mapi id 15.20.4308.026; Mon, 12 Jul 2021
 17:07:07 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: SOFT + NO_RETRANS_TIMEOUT semantics
Thread-Topic: SOFT + NO_RETRANS_TIMEOUT semantics
Thread-Index: AQHXd0BYAPlUDv7myUCZIzGi/bl7LQ==
Date:   Mon, 12 Jul 2021 17:07:07 +0000
Message-ID: <981B8D74-2193-498C-8C4F-190E263FD8F6@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: hammerspace.com; dkim=none (message not signed)
 header.d=none;hammerspace.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 34931bf2-921f-43a5-548f-08d945577ae9
x-ms-traffictypediagnostic: BY5PR10MB3860:
x-microsoft-antispam-prvs: <BY5PR10MB3860612BC48F15BA1F8C6A9193159@BY5PR10MB3860.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6QhNvmd51CrX2wf+xNJORsm1n6SkasJGeaNaxDRTkgH/yC3rMhBzVQysGWQ8A533x1kksSOlbiCP7TquVGOUuGC072lHF984uFu37xXdXbigxZvGBXk1CA1Sq45sQ13MFpzSK46/C+FkNpSv7axR+iQtwe/L1nJOiYXAu0MFbVSFuQQndJQpIeqMvk6Sw0KOaoGtb4NbSka5cRyGurDor7wrzRg+WIP9P82TgXveJ8hXYY0Nm+voKY00njGgMhIRYAhlfF9vcy76cbhaSDysjQ8MjEgBExtuFlJfWIVB9ZagTvtifJksKkcyClCVcf/398TkQxKGRAYZIYZ7jH9w8xto7qHjxvleMPQUs7wLABBLwlWUpmYi5MbfF9hB3DAYRCNX/BcELEoz+a6Z4xglsRAbXoU2hWDV+OSKmtVrZecHOgZJ90vEn+dH7P3oRPHqtsgS6bkkbAWoDVTCY/03X3S/W9WqaRCmpwqwOqCvFjiJ7IiqlCwRfvp+uG9CWpsGex5kPnAdZBhBZN34HApX8R38e0z9ZhDWgY/aaQu5bQ3MqXbPXaYy4YaSjJBsV3JF6x9mV2NshZ2gNgc+7nmhHVTZlpCIdAfSr1OQUX3WXQ/vZni8feOoiVvExQH0WE24Da9OWAo8CLy5zi0+NBrNK5lPv+5pRStM7HtaY7xoJQO81iZHjh1ZLUjy9LOdkxEI7Xj0Mxey0BGt1RxLj0hjag==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(346002)(39860400002)(396003)(376002)(6916009)(86362001)(8676002)(6486002)(6512007)(2616005)(33656002)(26005)(186003)(71200400001)(478600001)(8936002)(5660300002)(122000001)(91956017)(316002)(66556008)(66446008)(64756008)(83380400001)(76116006)(66946007)(38100700002)(66476007)(4326008)(6506007)(36756003)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CWg3CeNQLTMe5zetxuJllGP96iXDyCGPlmoAe8oUiksUy0JVdN7JrFBZ4cIN?=
 =?us-ascii?Q?GULelJtslb/M2dfIyh1hPtIVF5MjFWrPMIWZytOiNKpe9/LDbfZ5aviNARsK?=
 =?us-ascii?Q?JHmJeXxXl/GftQYYxDROf5HcD4K+A/jWg73S3oPSB5T0sNh/CZHye+WLjFps?=
 =?us-ascii?Q?pW2ynBNi4hIuFY4GzlJBgf/BTKm4wejsA854kTBCNnV7Qq1b+oNSpTd2ym7v?=
 =?us-ascii?Q?IiqKCqWQtAW3BMok5hUOyunX/7F9GYvx/Y5y+b4/8ioL+/MgapYeaM2ePXVO?=
 =?us-ascii?Q?FO8DWdub4fTTt+8NxGXgFeroN3geOfhQy2qwmziTXT1qEMUwgEyYzcATWoxw?=
 =?us-ascii?Q?mo8PhFi2wNK+MGQFwSDNt8VVmdWsYOJCP82SZTh3XNeZu34QaVlyxdff6GC5?=
 =?us-ascii?Q?PrVDCOCuzDxhCL/jx6wkp2LQupnkoofsxSp5TTh/nYMlbfLTCc+KvovyQPko?=
 =?us-ascii?Q?oC6mOH2cgknZz8NSnJ8wCwJwMIYTmAUJueOGlqnwCxlx3xDv1igN2aEc/eKe?=
 =?us-ascii?Q?UJpJFaIANEcPODTX8bmPGwUexg1uwGGtuuvtz1UBEU0B7SwJ4h7dQCwN870B?=
 =?us-ascii?Q?6CkQZDvwMYfgqRaTX3hDJqR5qzdmrbJFADxTsqBZCsvLEvnV7xxmBMonJ3kc?=
 =?us-ascii?Q?wsO+kpbRNuXFUXYYa/xGDoT2bj9C6as1HvxnfZDaLhbOyy5q48tK9VhIGRg5?=
 =?us-ascii?Q?bsYiCY9mpQ6dZVntKG5E3+XtOWI258W+zeZI+H88r/q3PDUEVzC/cGQoqou/?=
 =?us-ascii?Q?gjeVe1r2tWGdY1AjusWb0Jl8xfOjuiAQNWDNCJXCndgFamlfKgxTItwPmIsN?=
 =?us-ascii?Q?Oszegkou82eS6IjzTSTiZJZtSZFh2Pz/OepA6BGv2mX6JNAtPqCvipdqBbSK?=
 =?us-ascii?Q?hptyEJdq99Mh70XPD6yITTJs5enhb90sdrL5m1UIJiIT0IzGcVo9jUbFe2Ga?=
 =?us-ascii?Q?VJQ7ddRhvQKrkDQzX5zzjxEPSLwF+hhjN8i3mPYTNsxA/6iUiPfuYJCxc0y6?=
 =?us-ascii?Q?Jh/LXtnPcSub5yQ6qaiK5yHN62X4Efr4mhdBMpy4w6BmyvKkj36MsL3B/9/E?=
 =?us-ascii?Q?4nVPOAdpZZfJp8PxPmsrhhyEMx4bZYY4Hmu30tNqWXm7eK6wqOvdRN8Q0xEj?=
 =?us-ascii?Q?DFOd4jNhFnlRN8PPgR4BF/Hu5FO1ZRDK4CbfWe3EZ14qx2cSgxVinTMJpk8R?=
 =?us-ascii?Q?OsVQvDmYhhVykY+C2K4H3YdDmTEGkD33zp9CbzPgC/sXciPOmXH3gXXRM2Pr?=
 =?us-ascii?Q?6YrtFZJ1VlaLd5RBkLpUpy47msNTT6vqEybX/svJQmpkA8Wqp77qHqnFvJGk?=
 =?us-ascii?Q?TdQh8vQmRYeWt0HdWBcGacT9?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C3E65C69248A9A4DB20ACEFABDDE6B12@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34931bf2-921f-43a5-548f-08d945577ae9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2021 17:07:07.5113
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WCtvgOozK/+wv6d0efXlHi67GsP2PkW58UI+sRBrtFBjVXwLUSsa3+6lGNXGBrow5zmJGvkZ/fMlnFM3Mc82Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3860
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10043 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107120126
X-Proofpoint-ORIG-GUID: 3uxKkT3pyXB00nzRECc40YfwarjOgPGR
X-Proofpoint-GUID: 3uxKkT3pyXB00nzRECc40YfwarjOgPGR
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond-

I'm seeing some interesting client hangs that arise from a well-
timed server crash or network partition.

The easiest to see is gss_destroy() on an Kerberized NFSv4 mount.

NFSv4 asserts the RPC_TASK_NO_RETRANS_TIMEOUT flag (hereafter I'll
refer to it as NORTO) when creating a new rpc_clnt. The initial
rpc_ping() for that rpc_clnt is done before the logic that sets
cl_noretranstimeo, thus that ping works as expected (SOFT |
SOFTCONN) and can time out properly if the server isn't
responsive.

However, once that ping succeeds, cl_noretranstimeo is asserted,
and all subsequent RPC requests on that rpc_clnt are with NORTO
semantics.

When it comes time to destroy the GSS context for that rpc_clnt,
the NULL procedure with the GSS decorations is sent with SOFT |
SOFTCONN | NORTO. If the server isn't responding at that point,
the client continues to retransmit the GSS context destruction
request forever, and the xprt and possibly the nfs_client are
pinned.

The problem also arises for lease management operations such as
singleton SEQUENCE or RENEW requests. These are also done with
SOFT, as I recall they need to time out properly. But with
NORTO + SOFT, they will be retried until a connection loss that
might never come.

I've thought of some ways to modify the cl_noretranstimeo logic
such that it can be disabled for particular RPC tasks, though
none is really striking me as exceptionally clever:

 - Add a field to struct rpc_procinfo that contains a mask of
   RPC_TASK flags to clear for each procedure.
 - Add logic to rpc_task_set_client() that clears NORTO in
   some special cases.
 - Reverse the meaning of NORTO (e.g., make it
   RPC_TASK_RETRANS_TIMEOUT) so that it can be set by a caller
   for particular RPC tasks if the rpc_clnt-default behavior
   is NORTO.

Any thoughts?

--
Chuck Lever



