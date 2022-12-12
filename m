Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053A264A9B0
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Dec 2022 22:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233529AbiLLVqt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Dec 2022 16:46:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233584AbiLLVqe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Dec 2022 16:46:34 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B4A19C39;
        Mon, 12 Dec 2022 13:46:32 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BCGwopc029989;
        Mon, 12 Dec 2022 21:46:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=xiZfGRgG9lVh4ojuXgnaHPiqf+slq2hBHx94yyXsx4k=;
 b=dRmUGvdjg+3VW1cuO0+aL6l4z1Bkuy62E4PyixHaXshOvA4sfVjNscYFl1LiceEDOFTW
 YUp/fIuUBsHK65cOOm/9I3oI4PzmvniAYVi5JVw8cebTI+CxvVpUIiq4wTqm0OrlXZ6D
 2z9ePjsu8ImCoZisuxrAZPgyO3+vFt9nwtm7zeN+EfQR2wAbaHwLM4zQCDwQ47YWz1cE
 icODxi5U7ODMT4OqefaN5XnT79gYcTmLmiRs6DwieskDCQAvXiiwSg3B4kClu4/ejlfZ
 BIbstKwKUc1dKe/sAa/DDCfZblV2zL4GGUjnsA5FXgcU7NmdT2AU70KqHjk/qEprzGsZ Qg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mcj093xxe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Dec 2022 21:46:29 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BCKgYc7031734;
        Mon, 12 Dec 2022 21:46:28 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mcgj4p4fw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Dec 2022 21:46:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kea78fsRXNWFAFCfAEftDb2YRXvekTofG+8sc+l/tS9jH+olmIRbbicuQ6jGG4aw1nKoqqqdO+Ie5bVAn2QbmJgJkNFdLh1b/5Sx3bv1LqJpGbDzm3BUoTP4JL7DTdFfnpOhUk+UsBS5T2quuoExSnjTYhvJ1EYi0ADw1VIFo2DRWZA5WoSlcLYx4KwEjE71X4QHzaak/rNVZ2Qpw+9uGFnrQtAqxv5ZsQ+cabsmPOkiw+xWjuSGIPLL2tvxkGXJvcogLH4kk/UXOeinhxt/yG5mmu73p0jpvVOXMxLhUSj+QJzz5WOAHmqZFPaN3OKG3YnUu/lVaJpFjbdK5Ic5ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xiZfGRgG9lVh4ojuXgnaHPiqf+slq2hBHx94yyXsx4k=;
 b=XNDhsx56f6yxDTeGwAANOvpDoIH1WSdC13T0mCg6oCyMAIK/t4YS61BPwFRocC2C4FcMVnFPI9RghVEPIJzNFgM+aDsTP9ts9PNbYornndsfkcGUvTTUtoJzYkzG+g/mL9KfC2uRh7ksQvRtj9tilk1PK9hOBy2pc+5K+DHIpVxyZKPeqG99CMtLznh2hshZqjdc27B9ax6mGmeBEVDLcwv6looQu7Jm66xHgXjeEMqpO37pGv/K95SmzUnXngQg29wDqQB3hkOZtLCJpQ4k2w6LoZX9HHuE4M26cr5Wo6GyBFVi8W6yu8rWSq7O+BuWhCKCJN+98cKC0FmJSkvieg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xiZfGRgG9lVh4ojuXgnaHPiqf+slq2hBHx94yyXsx4k=;
 b=yvTjCtpyuLAU86EUkGnxUkddgsK9T7xov95EVkppjq57hQTFXJrPDPDqVfBgmNNeOQYh74o6eDyT44HcKXJkmQ0WIrgYr6y+mdVDAEqaO2ImqI13BiBIj8hllWrWu2U/07X6gURMREiq7SjZjB2AYintTZkV9WDkLejie0RDEQY=
Received: from CH0PR10MB5131.namprd10.prod.outlook.com (2603:10b6:610:c6::24)
 by BLAPR10MB4948.namprd10.prod.outlook.com (2603:10b6:208:307::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 21:46:26 +0000
Received: from CH0PR10MB5131.namprd10.prod.outlook.com
 ([fe80::773f:eb65:8d20:f9c8]) by CH0PR10MB5131.namprd10.prod.outlook.com
 ([fe80::773f:eb65:8d20:f9c8%6]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 21:46:26 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
Subject: [GIT PULL] initial nfsd updates for v6.2
Thread-Topic: [GIT PULL] initial nfsd updates for v6.2
Thread-Index: AQHZDnMvR7sPYtZkQ0Sf4RLWgMFQ9g==
Date:   Mon, 12 Dec 2022 21:46:26 +0000
Message-ID: <ECE34A45-6FD7-4559-8F68-9340E6B3FDC6@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR10MB5131:EE_|BLAPR10MB4948:EE_
x-ms-office365-filtering-correlation-id: 1520563f-ef55-45f6-18bb-08dadc8a51d0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NEWmvDEeQxKsPrL/xu994U2rjHIEIe62Z8pZqEqFENjLMv1d6U/pXmEWytWzlRXceyGyoChi0TxFgu14JqWkSgWOpvdv59xITKqVViDV/Ims7vB5awqTd6RW5oApJzO7taG/tO77+1XovuEUxwV0S/hBOc2TAAEpaGomsajmGhW3KWFjpb83Y6Gj7GxfbGsjZVnihpB5jAOjmoV6joe6cmis1kTe3azYMr1u0lTAEa4Q8uShPDDOzWQXeRg3tXkxOKDgTv7o+TZflONQ5NXzcEGYA/3GQjhT58tTkbEKbmnVLn09ZtGAIjd/fnikXtP+1zV27P94+72oWqK75odVKa5tasudbLXpuwYrVxWY28Yib8+f7mh0epLJ+pjCEtugPS3UqdBFpL8Dch8Lsnqn++b7I+CO06q7ZhIAWWO041MEckLM711YRHEJXoTej6LycTD9qBCun7vAitzikDT/26m01KUIA3DxS/jmDPtpKYexQuGgkgHw3CItTT7apYOhkNRrkjyNWMQYzRAiBTzDOJBv7+YbOVdQj9f19mP7bgcKFO4cyd+NeIFtAl/H5YlW3+yuqnTfqDBKC6G9tKa+uiOtoe22LqHg+oJcBhqXRAbTJFSV5lFT9SoTk8dizGOP0wNfYIJOOAj4ufe1iULv7kJQ8iP7hVqprh+rBpdftQTldNjLvs7qQFkj3nAPPOenUZP8E4jfcbgnjYLbWoAlxTZwgs4TXRL0eppK1m8xZxk0vXHVrUGMP0mRlPbGxxpR8xZU6oLESTuXCbwTAJPmrA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5131.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(39860400002)(366004)(376002)(346002)(451199015)(316002)(6916009)(15650500001)(4001150100001)(54906003)(2906002)(33656002)(122000001)(8936002)(966005)(2616005)(38100700002)(478600001)(6506007)(38070700005)(71200400001)(83380400001)(36756003)(5660300002)(6486002)(41300700001)(66476007)(66946007)(76116006)(186003)(4326008)(8676002)(64756008)(66556008)(26005)(66446008)(6512007)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nxmzoLqMaOUqN3iEGF9yXvx/DKdQskx2Tjtfu0iYXB8ppFBT8Py69OFycLGa?=
 =?us-ascii?Q?ZmP5ioeIOtzUNfhHVl9POnqfete/VsVwQzF7iPkRdZDZA/geu/8BIPfijHy2?=
 =?us-ascii?Q?G3P4DZmrdGfUIkSm1f5AuJjp5G1K2BDtU2QbYawk/GgOMEqxj1WeCEm4ezwt?=
 =?us-ascii?Q?LAGht9OGJ+dIZz8/7Ax7Fn6amGuC907uwoIHlt3fvUeLWkx0elrV8wbRquZs?=
 =?us-ascii?Q?kD63ZtyvcZH+7yxRPpiPAUlvshLlxdqv0VLfnDvCCKXedGxu1o98NXa6NXUf?=
 =?us-ascii?Q?1g1hu9XqHd4zDvFNvf1Sj0VLGb1rpJvnp2nJB4JtvnLB8xxNA95mSgxRwfhB?=
 =?us-ascii?Q?ZPgFxMjrf6P+AMGaSHCHMwWygq0Xgw3nnMD9EidDPccF5knrIBukiowYngzF?=
 =?us-ascii?Q?t+qPcq4xUGlLoiSxwzva5l7ytYlJ1izp+UZAc3IlKC5OV4lKNiRcGmWDbdkU?=
 =?us-ascii?Q?KQhTShHt06ko18SkZprGbZQRgFBC+j38QphNLewDV+VWanCyDfD16mSuHeDA?=
 =?us-ascii?Q?UxtAePX2g+cN0yOmwMIkTNMEwG0sEHOjAg8705000bFd/1oFVGqSB5tGHZIA?=
 =?us-ascii?Q?TLmscFKykiRjxaqjizm/VuXqO3Smt8lacjPhvfcryWhGaT3AEj135QWVLshE?=
 =?us-ascii?Q?3kT4hY1T4m6ZCqj7k+o3vg9X5JYywAWuQNy3raI0N7U9jEYQWuwM6/noT1TB?=
 =?us-ascii?Q?NMzabOJx0aY77danUCkFoF3H4B4YY0qqgMGBS5S2Sp9TS6saEC/1KJri2tat?=
 =?us-ascii?Q?yuE+nGagxPwSMG9fdh4fTwKPYA3GSkjfuupZL/hT9qoDI4nX726HzbypbtVH?=
 =?us-ascii?Q?axIt9q4KgkHKuJYiM2shBFn/n23TQWWvS6Ibm5Lgban4jVworSWZK9z0uCMz?=
 =?us-ascii?Q?pJlsdnrBZNKBM/nV3Cb2rkncer7cwaWiwIvgz/N9Ml0RB8S8R9lnqopLKTm2?=
 =?us-ascii?Q?Sg7vDivePXAt+XbMIQ+yetVPc37Umvy9GwLpXyoUelyy/PA6QTi5PBT5M0GQ?=
 =?us-ascii?Q?veLAPPzi6vJpFHV6inDCRLW/5DFy8Ea0OFWoDhmhUBtRga6Vujlbaphy/RWh?=
 =?us-ascii?Q?VJ+lioR3c47xEcrHtUOnTmvESvrMZDm7166+/uHg9xNRb9l+Y+CiWMxDm9qV?=
 =?us-ascii?Q?3pdiIKCRb0KqHblIqLsClyQE4V2yy7OihqwQ4Bk4ToqmiZYfiYscPR+ruPqC?=
 =?us-ascii?Q?u2QXe/qziTX6s+2xGlflIiq4RahDyBJVlRjjtlwGq0otpEEn6piuY0qWPoXc?=
 =?us-ascii?Q?TIPonpwe5eXLVVVn3VcPdodty9fTU6uKDDvKGhNuhVyzPfsv4VRnbslfgHir?=
 =?us-ascii?Q?6WQvR8iUO+kU976iAmuXFQzyyWfxzjbaZqwI5qq+BRcEoWwijwDbp2yjG6MZ?=
 =?us-ascii?Q?Ju0XmDo2QnCRx3YVDfBtpXw7UuVTQ9EFjhutCY461Yh7YyC5cXviCMQZk6XJ?=
 =?us-ascii?Q?jE/pQGF+roxRRd9v+ev3lZ+L7UOzGcjVSIJDQR1BkLMSolqCjNFQgiLkGRFL?=
 =?us-ascii?Q?KjRYVF2gyKv7EHv+xuRJMbiqPH6BJs5Zj88zqJJeDZnSuEehQjnK20I0Dc+J?=
 =?us-ascii?Q?WSXnzpUa1hgt9N5XSvX5ostiXUJc//940v/TARuFowk6/wHsylgwDdlpLbZY?=
 =?us-ascii?Q?sg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C02207D572EEDC448C21F310E103F2D4@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5131.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1520563f-ef55-45f6-18bb-08dadc8a51d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2022 21:46:26.2380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u7EtBjze5K5S+OPZ4ymEf6v3nsIUblgJQZMv+RUoMbjUfFrseJD7IJQTvvX39MGs4Rv4Otx3lPq0ps+lBtv0Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4948
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-12_02,2022-12-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212120187
X-Proofpoint-ORIG-GUID: Ebf4_R04b32ylsxUNRHqsJ3hfVI06eN6
X-Proofpoint-GUID: Ebf4_R04b32ylsxUNRHqsJ3hfVI06eN6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Greetings Linus-

You may notice that towards the end of the commit list in this series
the CommitDate on individual commits is December 10. I had to drop a
patch from the middle of this series due to regressions.

Its replacement and a fix for the recent server-to-server copy crasher
will be on your virtual doorstep before the v6.2 merge window closes.

Meanwhile the remaining patches below have been percolating in
linux-next for quite some time. Please pull these for v6.2.


PR follows:


The following changes since commit b7b275e60bcd5f89771e865a8239325f86d9927d=
:

  Linux 6.1-rc7 (2022-11-27 13:31:48 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6=
.2

for you to fetch changes up to e78e274eb22d966258a3845acc71d3c5b8ee2ea8:

  NFSD: Avoid clashing function prototypes (2022-12-10 11:01:13 -0500)

----------------------------------------------------------------
NFSD 6.2 Release Notes

This release introduces support for the CB_RECALL_ANY operation.
NFSD can send this operation to request that clients return any
delegations they choose. The server uses this operation to handle
low memory scenarios or indicate to a client when that client has
reached the maximum number of delegations the server supports.

The NFSv4.2 READ_PLUS operation has been simplified temporarily
whilst support for sparse files in local filesystems and the VFS is
improved.

Two major data structure fixes appear in this release:

* The nfs4_file hash table is replaced with a resizable hash table
  to reduce the latency of NFSv4 OPEN operations.

* Reference counting in the NFSD filecache has been hardened against
  races.

In furtherance of removing support for NFSv2 in a subsequent kernel
release, a new Kconfig option enables server-side support for NFSv2
to be left out of a kernel build.

MAINTAINERS has been updated to indicate that changes to fs/exportfs
should go through the NFSD tree.

----------------------------------------------------------------
Anna Schumaker (1):
      NFSD: Simplify READ_PLUS

Brian Foster (1):
      NFSD: pass range end to vfs_fsync_range() instead of count

Chuck Lever (26):
      SUNRPC: Remove unused svc_rqst::rq_lock field
      NFSD: Finish converting the NFSv2 GETACL result encoder
      NFSD: Finish converting the NFSv3 GETACL result encoder
      NFSD: Pass the target nfsd_file to nfsd_commit()
      NFSD: Revert "NFSD: NFSv4 CLOSE should release an nfsd_file immediate=
ly"
      NFSD: Add an NFSD_FILE_GC flag to enable nfsd_file garbage collection
      NFSD: Flesh out a documenting comment for filecache.c
      NFSD: Clean up nfs4_preprocess_stateid_op() call sites
      NFSD: Trace stateids returned via DELEGRETURN
      NFSD: Trace delegation revocations
      NFSD: Use const pointers as parameters to fh_ helpers
      NFSD: Update file_hashtbl() helpers
      NFSD: Clean up nfsd4_init_file()
      NFSD: Add a nfsd4_file_hash_remove() helper
      NFSD: Clean up find_or_add_file()
      NFSD: Refactor find_file()
      NFSD: Use rhashtable for managing nfs4_file objects
      NFSD: Fix licensing header in filecache.c
      MAINTAINERS: NFSD should be responsible for fs/exportfs
      NFSD: Add an nfsd_file_fsync tracepoint
      trace: Relocate event helper files
      SUNRPC: Don't leak netobj memory when gss_read_proxy_verf() fails
      SUNRPC: Clean up xdr_write_pages()
      NFSD: Use only RQ_DROPME to signal the need to drop a reply
      SUNRPC: Make the svc_authenticate tracepoint conditional
      SUNRPC: Fix crasher in unwrap_integ_data()

Colin Ian King (1):
      NFSD: Remove redundant assignment to variable host_err

Dai Ngo (4):
      NFSD: refactoring courtesy_client_reaper to a generic low memory shri=
nker
      NFSD: add support for sending CB_RECALL_ANY
      NFSD: add delegation reaper to react to low memory condition
      NFSD: add CB_RECALL_ANY tracepoints

David Disseldorp (1):
      exportfs: use pr_debug for unreachable debug statements

Jeff Layton (11):
      nfsd: ignore requests to disable unsupported versions
      nfsd: move nfserrno() to vfs.c
      nfsd: allow disabling NFSv2 at compile time
      nfsd: don't call nfsd_file_put from client states seqfile display
      nfsd: remove the pages_flushed statistic from filecache
      nfsd: reorganize filecache.c
      nfsd: fix up the filecache laundrette scheduling
      nfsd: return error if nfs4_setacl fails
      lockd: set missing fl_flags field when retrieving args
      lockd: ensure we use the correct file descriptor when unlocking
      lockd: fix file selection in nlmsvc_cancel_blocked

Kees Cook (1):
      NFSD: Avoid clashing function prototypes

Li zeming (1):
      sunrpc: svc: Remove an unused static function svc_ungetu32()

Trond Myklebust (1):
      lockd: set other missing fields when unlocking files

Xiu Jianfeng (1):
      NFSD: Use struct_size() helper in alloc_session()

 MAINTAINERS                                           |   8 ++
 drivers/infiniband/core/cm_trace.h                    |   2 +-
 drivers/infiniband/core/cma_trace.h                   |   2 +-
 fs/exportfs/expfs.c                                   |   8 +-
 fs/lockd/svc4proc.c                                   |   1 +
 fs/lockd/svclock.c                                    |  17 ++--
 fs/lockd/svcproc.c                                    |   1 +
 fs/lockd/svcsubs.c                                    |  17 ++--
 fs/nfs/nfs4trace.h                                    |   6 +-
 fs/nfs/nfstrace.h                                     |   6 +-
 fs/nfsd/Kconfig                                       |  19 ++++-
 fs/nfsd/Makefile                                      |   5 +-
 fs/nfsd/blocklayout.c                                 |   1 +
 fs/nfsd/blocklayoutxdr.c                              |   1 +
 fs/nfsd/export.h                                      |   1 -
 fs/nfsd/filecache.c                                   | 241 ++++++++++++++=
+++++++++++++++++++----------------------
 fs/nfsd/filecache.h                                   |   4 +-
 fs/nfsd/flexfilelayout.c                              |   1 +
 fs/nfsd/nfs2acl.c                                     |  10 ---
 fs/nfsd/nfs3acl.c                                     |  30 ++-----
 fs/nfsd/nfs3proc.c                                    |  10 ++-
 fs/nfsd/nfs4callback.c                                |  72 ++++++++++++++=
+++
 fs/nfsd/nfs4idmap.c                                   |   1 +
 fs/nfsd/nfs4proc.c                                    |  49 +++++------
 fs/nfsd/nfs4state.c                                   | 345 ++++++++++++++=
+++++++++++++++++++++++++++++++++++++++-------------------------
 fs/nfsd/nfs4xdr.c                                     | 771 ++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++------------------------------------------------------------------------=
----------
 fs/nfsd/nfsctl.c                                      |   6 +-
 fs/nfsd/nfsd.h                                        |   3 +-
 fs/nfsd/nfsfh.h                                       |  10 ++-
 fs/nfsd/nfsproc.c                                     |  66 +-------------=
-
 fs/nfsd/nfssvc.c                                      |   8 +-
 fs/nfsd/state.h                                       |  11 ++-
 fs/nfsd/trace.h                                       | 144 ++++++++++++++=
++++++++++++++++++-
 fs/nfsd/vfs.c                                         |  83 ++++++++++++++=
+----
 fs/nfsd/vfs.h                                         |   4 +-
 fs/nfsd/xdr4.h                                        |   5 ++
 fs/nfsd/xdr4cb.h                                      |   6 ++
 include/linux/nfs4.h                                  |  13 +++
 include/linux/sunrpc/svc.h                            |   8 --
 include/trace/events/rpcgss.h                         |   2 +-
 include/trace/events/rpcrdma.h                        |   4 +-
 include/trace/events/sunrpc.h                         |   6 +-
 include/trace/{events =3D> misc}/fs.h                   |   0
 include/trace/{events =3D> misc}/nfs.h                  |  12 +++
 include/trace/{events =3D> misc}/rdma.h                 |   0
 include/trace/{events/sunrpc_base.h =3D> misc/sunrpc.h} |   0
 net/sunrpc/auth_gss/svcauth_gss.c                     |  64 +++++++++-----=
-
 net/sunrpc/svc.c                                      |   4 +-
 net/sunrpc/xdr.c                                      |  22 ++---
 49 files changed, 1302 insertions(+), 808 deletions(-)
 rename include/trace/{events =3D> misc}/fs.h (100%)
 rename include/trace/{events =3D> misc}/nfs.h (96%)
 rename include/trace/{events =3D> misc}/rdma.h (100%)
 rename include/trace/{events/sunrpc_base.h =3D> misc/sunrpc.h} (100%)
--
Chuck Lever



