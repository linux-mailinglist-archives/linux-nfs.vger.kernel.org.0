Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD1F147B0AB
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Dec 2021 16:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236745AbhLTPvT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Dec 2021 10:51:19 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:31332 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235507AbhLTPvS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Dec 2021 10:51:18 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BKEDCgu013068;
        Mon, 20 Dec 2021 15:51:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=KERFElJQJMAROig3C6TGNnSH5sP7u50shZxk1LCi0dI=;
 b=dmJGCPyKKGQCr3XI0EJeBVBX4GgK4WJPd+0GiyQDXCVRh9QC64hEjrVUfNAdIQWGPd8B
 tMU2jMMqy1NSWEjvCkOBQuoMqVa4OjpJ7Ds8qOqXDfggxPYgiKNBEmI1y3kALa/LTUHz
 ACX3OtsSGseipGOi4L3PR/+OU9shZ6TB0U3Gt8XxWAfijYySroN0NdBFvlXL7PdaGuhR
 VEGmsGBdWijYXkI7FMi2T/rzXG7Etq6hEQoX+pWeqk8eN+ajWpeT7FkX6yIvEcVtS5Pq
 3Z3R0jTCB9uO0vYaYbRBIw7dEGN+TDw3BozyES5rBnq+LeysoEUEJJ3zqIK2WFp9ui+1 8w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3d2udc89gk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Dec 2021 15:51:13 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BKFkNkV091335;
        Mon, 20 Dec 2021 15:51:12 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by userp3020.oracle.com with ESMTP id 3d193ktynh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Dec 2021 15:51:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TgAgDh3kYhlMlpoufyWyfqS5SCcFq7NwAqp+4MPcqb397C/eptG2gfUjr3I4/7A3iCJE62qtBE0R8837GysKsqV+1zXwo+rq+UqoqXbmwJz4azNGjrI3lw9rBZ7pplRJCr5lMk7IVBc5ai0S4vZapJm3Q7AwF6YLPBqqmxDymzdqW1wmyt2s+vQJ7I54BlJ3oISM/dRcuRYsSEZUpUkY6NQlfp81ocQFgjf4reiBS0qNjyJ3d+311QWUN570nJdJrbt8XHq8RLBr9wyQyhL5RDl2yAbWZpVD0aGjU31OO6Y5TyS5t1w7ShXvvdaNVnM82K8vc3FzjwP8OGq/+OZ0iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KERFElJQJMAROig3C6TGNnSH5sP7u50shZxk1LCi0dI=;
 b=QkQouRcy0cI+zKhhDNbEIgOdn2Gv+CE6BV1G2RVARxW3dI/TxrauRzBtqqPUwY7LNsqnvfftTirgAYFvbwSLyuigug4gdr78/Lh+XDfRXU1VMWK2jLGUuGKiYX+QzlyvJ7aMMxe28OXzYk1QGmfiJzir6mwNEsdAoGpXZD/8FvJyfCt1BU26oWQBvBoJs+I265N3Dj8Jkq4FniEMihpQDlyvBp30GaqWflx2uqcYhw1S7ztsBTLVptC4KQRXSp6VTgprvM06sPV684ZQXLnvllYx1PBTp5Zyh8xh/PUSZVF6lTtVbqwoigw3ujZq3VMARYUPQvyebVZEhlfBBFHOUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KERFElJQJMAROig3C6TGNnSH5sP7u50shZxk1LCi0dI=;
 b=Mit6G2jSoUmGfSJQByQAmqxZStl9+1Ah+U8Z0gHMlkPWpWa8nFERuS02FvR99x6cgXzoJcSAY5cHWCFNy67luGHhHMdmWXhK7kEEQpyHaUXJrOBPY1QEmF2Q5OOVjfCJtut3siXdsW04YBouMctdkLJuy1Lf3DlV59Uxr4s4rnM=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by CH2PR10MB4310.namprd10.prod.outlook.com (2603:10b6:610:ab::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Mon, 20 Dec
 2021 15:51:09 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7%6]) with mapi id 15.20.4801.020; Mon, 20 Dec 2021
 15:51:09 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     "trondmy@kernel.org" <trondmy@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Bruce Fields <bfields@redhat.com>
Subject: Re: [PATCH v2 10/10] nfsd: Ignore rpcbind errors on nfsd startup
Thread-Topic: [PATCH v2 10/10] nfsd: Ignore rpcbind errors on nfsd startup
Thread-Index: AQHX9HoJf0UrhpbILEawWnDLCGoAp6w6H74AgAArPACAAT7dAA==
Date:   Mon, 20 Dec 2021 15:51:09 +0000
Message-ID: <316378A4-BCB1-4C8F-A16D-43F8F9DA8FBC@oracle.com>
References: <20211219013803.324724-1-trondmy@kernel.org>
 <20211219013803.324724-2-trondmy@kernel.org>
 <20211219013803.324724-3-trondmy@kernel.org>
 <20211219013803.324724-4-trondmy@kernel.org>
 <20211219013803.324724-5-trondmy@kernel.org>
 <20211219013803.324724-6-trondmy@kernel.org>
 <20211219013803.324724-7-trondmy@kernel.org>
 <20211219013803.324724-8-trondmy@kernel.org>
 <20211219013803.324724-9-trondmy@kernel.org>
 <20211219013803.324724-10-trondmy@kernel.org>
 <20211219013803.324724-11-trondmy@kernel.org>
 <831659F6-3005-459B-92ED-933BBCEE6FE9@oracle.com>
 <3167a9a815ac9c82700bd58d8c421de31eee8b91.camel@hammerspace.com>
In-Reply-To: <3167a9a815ac9c82700bd58d8c421de31eee8b91.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a716eb32-9dc5-4b5a-0173-08d9c3d08acf
x-ms-traffictypediagnostic: CH2PR10MB4310:EE_
x-microsoft-antispam-prvs: <CH2PR10MB4310A94BD0839FDE27C910CB937B9@CH2PR10MB4310.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: beRFhzzl6H3VpYnS1PxI5kq6H43BX5NgeVLtMtrtluaRF6c7/E0twpXJkGl4J8NnNGKvUue+dcL0VQnRe679k+AoKYXuMon0GIZTmN5pDqGFDc07Yik+x+dgBptpb1UAebH+eLk3sJOSdp68AZvBWjb7JeCcun/b46gWjWebgB9VPsJ6X1dGaacSfoPeC4WzQ3yeMqt2p4i3a2bLNS5ec0xsLFQL8DUy4YqtXzkGVoR+ahTM0yfqQE7BpPdj+shJpDhvEtjHSz1lEdD3XMflHJMGor5aa9lGU3gT3Je5iV4+sWBnyZMbsThMiEMBRopa+9nbd6p41FpnE0MdHthTpCnyy8B+XPzJJ6zGEjXxwQz/SGxwz3Uxr2mnTflenfYjzn3eEmMIr5C/cMwoaMhXXtY1NAo0P5OIkC+2Tc5PMhfSBSzBJ8hkVMqRG/JHmAk1A2T206+SCr0Jge7jYwVOaeh4zwLSRfujQCKCapgVE4LTc9W0md2G2H2SRaicazPMGxb0bO2vEpVh9PV+oHktdhugkkTk3r9docbUHt8nJzuw5AGDlZHDL7LO18ks1mcly7YdYlz0cP9zF+vQCtvWF6gO1i6Z8PSppJEMoRM4RAOKiEVoBVtLSlWprhtCOaQ4sOz0sjw04u1+JTw4WUfRluvcn6Jw8j0eBSfE/MI+u4oX/rmhKw18JlkrGGoBby5kymmSG28uZP99K4TkP/frOc3BPGhL1wJkDyjf7JFo6b0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(33656002)(8676002)(2616005)(5660300002)(4326008)(2906002)(8936002)(6916009)(38100700002)(316002)(6512007)(83380400001)(4001150100001)(71200400001)(54906003)(122000001)(36756003)(6486002)(38070700005)(66446008)(6506007)(76116006)(86362001)(53546011)(186003)(66946007)(26005)(66556008)(66476007)(508600001)(64756008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yTvsnIV8U/wcqxaIxGruRopWwhLFh0btc5gRrhBOAzb7I1e+HrQztoiIQU3W?=
 =?us-ascii?Q?tnUYsCFU4AuNLDTobg4UrmsuH0kvOOeObTlow36GRkzu00bvp5U7lRE72D4W?=
 =?us-ascii?Q?Y5zp1kfmP7eAvnvnVziKnRSNYOkDg4Mh/VHf5+/sW+mWl7CVF+fw/55gahYW?=
 =?us-ascii?Q?hTC9vgDor8hQJsk/9SYZhadrw0VVHGTxOGpAXTuB/si3zMdLZ7I4bcRFCNL0?=
 =?us-ascii?Q?zqS9xlPOLHASmIGjJZlX8w27ynM5DvslpPyOLZtimzVJ+s8qpz0glS349suV?=
 =?us-ascii?Q?VORyr5IUHIMYYCjuVyfybW9rm514SbNBIypT7eTX5nrwtvIwVSnnTJalt42A?=
 =?us-ascii?Q?VtM94SlLr3CmqY4XCDYXg9cpH1PVI/1HQLQMzh19HMhhNKwpiHwuvPeJb33N?=
 =?us-ascii?Q?AG2SgAcaVK7hx9aKHb1h3taO4mJ5yNQ6KC92/CXnQYn3cLmWVuLhKrS+MMT4?=
 =?us-ascii?Q?JlzeCD6Tj3/knf7Ot0fmE1t0UzL7XFa7UYxSygO/8X7ot2KdJBRm+Fh8Zxrq?=
 =?us-ascii?Q?S0Xry+Ez+z8noQRxPfFJLA5D5BDK8YXu8aCjBuy/XafCjqUMckXrjycIXQaW?=
 =?us-ascii?Q?T8ooGaHlS+EFYfKpLD6C/huYeZd6Hbn/t5FwLHT48yxDupyTOHigafGOSqmS?=
 =?us-ascii?Q?yMSd4Zos4xiSG8PWk6eVSrWe8cnnR7WzdPmR8NgmYGTqfJCz6Iw9TtJyhWpu?=
 =?us-ascii?Q?m8EcNNpidD1m038/a6iY6+LdpgQ+OqyIyE+ZK42oH+Rmj2Renya0agPSaWo/?=
 =?us-ascii?Q?0UpMYLD8KRzD3pSem1KggoF00mDGgsbeCyIrJ+o8BE/MAqQQqt6AfSq5FLsP?=
 =?us-ascii?Q?vuZe8nydFeBKhbgizAMBGEZJhMD9XdvCi105/yourZ2Avwal2pZ7H4v6Jf2n?=
 =?us-ascii?Q?Aor8h9Zn04JP63ch6MCHl3K7AB5brSxgaM8XdANUSxJDWHENWMGRL9Q8aVim?=
 =?us-ascii?Q?7y+/1MDwenTg4Z8K8cgDnpeaQCY0tfGnENmfkc8Gjc5vzGwzfTbUNdXLeWCO?=
 =?us-ascii?Q?1A0UgyqHpJfMPTD1txYx97C4ISqhP6gshsx3BTJZg1xRHfoVGKFknVSpfhXK?=
 =?us-ascii?Q?HQe1rzZnQiZTlBiOjF2I/f8yJHyMN2s0bt+ng9N0zz4pm94yfX8sa9jo7d7G?=
 =?us-ascii?Q?fQcxXdDA1J2H0zw7akURyFYQG4BjvJbc93Z/eSV1HopVPH8DopKO3W9dTEpg?=
 =?us-ascii?Q?aY+QP8tqUTHDJxkilyFzQfXW2eXZ8V3UNWeA+R4ETqW5BeSfZtgt7NQSjoRC?=
 =?us-ascii?Q?moWhSB0VjTvIO9lkUz3z84QE6ATARahBr9GF/leeU+7BP4lnMus7iOm0ywBm?=
 =?us-ascii?Q?SejWkCbYtOVfKseaVnFPhcD6TNG/4pTW66A714etCu/9nAZZBt1HnGvmdeYW?=
 =?us-ascii?Q?rriwy6NzbyQoQ/waaT/pzcqJds0NX8zkHlslpjQADtRuEGyYfscn9/9Ld6Pw?=
 =?us-ascii?Q?FkO6GZOhYotazTHm66oJjdpSAOOXk+RExKHRXVxQW+fk5Rfp6OTvZbygwYPn?=
 =?us-ascii?Q?YaebZN+j2MvlTYUBs8UD/RsQ3kFqB6rUhaU4zoCdg7ngrcHF72+C++QQ9Gdm?=
 =?us-ascii?Q?lx4iEag0uvZB0tdWqxvd1CK2nRU4Ch+YwR3e5yAPsmqqKpV0FgV4DxQI6yXl?=
 =?us-ascii?Q?llfox0b33tc+4DsUYrHvJCU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <646F4625A7834340B03180E636F26412@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a716eb32-9dc5-4b5a-0173-08d9c3d08acf
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2021 15:51:09.8446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Ueq/9VhyUv6BRdfWfaTK6ePXyMzFCprzUgEJfv734WckO5hgWH2tpUuxcTf1wagQ8GNGP0ftAw1kwS4Y4qIog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4310
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10203 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112200090
X-Proofpoint-ORIG-GUID: N4Aarxh2D6VLyArzea9fWybQyYVAwF39
X-Proofpoint-GUID: N4Aarxh2D6VLyArzea9fWybQyYVAwF39
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Dec 19, 2021, at 3:49 PM, Trond Myklebust <trondmy@hammerspace.com> wr=
ote:
>=20
> On Sun, 2021-12-19 at 18:15 +0000, Chuck Lever III wrote:
>>=20
>>> On Dec 18, 2021, at 8:38 PM, trondmy@kernel.org wrote:
>>>=20
>>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>>>=20
>>> NFSv4 doesn't need rpcbind, so let's not refuse to start up just
>>> because
>>> the rpcbind registration failed.
>>=20
>> Commit 7e55b59b2f32 ("SUNRPC/NFSD: Support a new option for ignoring
>> the result of svc_register") added vs_rpcb_optnl, which is already
>> set for nfsd4_version4. Is that not adequate?
>>=20
>=20
> The other issue is that under certain circumstances, you may also want
> to run NFSv3 without rpcbind support. For instance, when you have a
> knfsd server instance running as a data server, there is typically no
> need to run rpcbind.

So what you are saying is that you'd like this to be a run-time setting
instead of a compile-time setting. Got it.

Note that this patch adds a non-container-aware administrative API. For
the same reasons I NAK'd 9/10, I'm going to NAK this one and ask that
you provide a version that is container-aware (ideally: not a module
parameter).

The new implementation should remove vs_rpcb_optnl, as a clean up.


--
Chuck Lever



