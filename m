Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC03031CDC4
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Feb 2021 17:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbhBPQOv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Feb 2021 11:14:51 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:58890 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbhBPQOE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 Feb 2021 11:14:04 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11GFsxeI098297;
        Tue, 16 Feb 2021 16:13:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=mvpEcZ518mpWZeN6ej0t/fCE2ExXVZfXT/B8IpgbYXI=;
 b=V1AcMGCb+j6daCJzx91EwB05efKvssP9ScFhlj4+qc2gM7jeURW5N1u1pKPnyWlt0nIN
 WHhTZeqfhA2Th2YFT9MPT4NWo5qJNLDOy5zaZnR/Uaif1+sMWMLjmr4LoXPL9qV9EVLK
 5SaPhN7QYYLXqC+UCm3+GLaO7sCgNkBzLQXr8hiYjK1M4QIa0xFUJiYMC30VWJkPItQX
 M2r6DJ8jApssyrsRN2oUg5ZbZW+e+4n4D0oKqc1fs8ki0seJVRaIh109JHCmLSV0C4sy
 Z+af3UEVwCwpekXkAAJEkUwUMRva0HH+iWBYsefxlTH7uAIhT5XDHpk6N6iYMX6bSYDz XA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 36p66qycca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Feb 2021 16:13:17 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11GGCDBl009389;
        Tue, 16 Feb 2021 16:13:16 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by aserp3020.oracle.com with ESMTP id 36prny3vju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Feb 2021 16:13:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NozAcSZErrqIZu/frIq7js7XbDgizGEEIALRgl+V6bMXHHVDu94PwvAOb+AtH0HBvdGARijRrF9wEu3Lm4YrZQSjgxsFmDXx0PbTJ0qZEVO2LZZGHTi8pDtc2zPIkRODBVDAlhc/pio89Rav4Cl9FQP5ZhDhQcym9Yb5AvQSgCdvhtrE8VSzaZv369jJPX6n6Ck2Wo1LWPBPY1diQQhf4mljIUkU++RKzufEK73goCpRWm+07oMS/oVk+cUnM3VSKbpkTtx02yjNTRAH8fXt39Hi8tySyK8TeQwhfbM9O5aGkrWHUHNlc5guJ3mt7gnlcQkiYo1i366zY56qr7NuvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mvpEcZ518mpWZeN6ej0t/fCE2ExXVZfXT/B8IpgbYXI=;
 b=ni7vATHlVl/NLlBolLjbxrpP2JXHl55NKPy040HQmTX8uI/UjG6SSEzkmnYfOGuelvcT7lCUVTCSBqeBJFNLOB3S0BxCI4ayTWDEaOrqeupLjOk6qmJLT5JDGbUsR1ItKLRJwnFib8zOOnsFq/laFzX0y4emjQkTPocjNPV44TgXK6pfwkEdPI74MKEtaPAIEd8zY19bot9q4pO1nVjkVWkDa59tmEbO0lNIV4OJgSiuynI1WkRMZvNWsucqQgNlgrwko27NNk3gx8vKl/KgT22uS1S/7U49B8eA+amRjVNQLvr78D5yFZgvmbp5xHNgWP48UcB2c8j+g8Xnq0g9TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mvpEcZ518mpWZeN6ej0t/fCE2ExXVZfXT/B8IpgbYXI=;
 b=HZafTM9P5EKcKr2+U8PmJaA8swQVORp0bB3aBatqi7LoNOPVqFhIwqSXiwLYY85TZinOH9Y9kQShHA1ka8t7q1/xKIQTNU6hRpTGkrSW2di7xWADm/PRXm7j7krcobUf+ob56LpSXQWw3HqSjp80OQ9hr4UEwLxdghmjwg6Q/Ac=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3670.namprd10.prod.outlook.com (2603:10b6:a03:124::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Tue, 16 Feb
 2021 16:13:13 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3846.043; Tue, 16 Feb 2021
 16:13:13 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Bruce Fields <bfields@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: [GIT PULL] nfsd changes for 5.12
Thread-Topic: [GIT PULL] nfsd changes for 5.12
Thread-Index: AQHXBH6gxh+Z8W2lf0Cp+1yEL5JVWw==
Date:   Tue, 16 Feb 2021 16:13:13 +0000
Message-ID: <E90C3C1D-7D82-40E5-ACF1-44CB86B362BB@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 995727c4-0951-432b-f500-08d8d295c334
x-ms-traffictypediagnostic: BYAPR10MB3670:
x-microsoft-antispam-prvs: <BYAPR10MB367012C64FAEB2AD587E12ED93879@BYAPR10MB3670.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Mnaf0ys86McY7HqvqDU6CrqLWlzhkIzRIuCNvYGNoacGtn7q1hFCv3J/n+hOuHvCphd1jJcXdH5BMh6WutMHoBAcTCbKo/YuBHuJ0RG8v78g5irEp9ow2ryDd9jp6g/v9cQtd/gIFyOdlCp/fH5xKBJEKVt237S2QSGY77tMd4PXIgDLxSl0IE6i4TSwex1oCS8aHL4qjqGvq1Yed1eBYviMXNOOFgmnx2siawTWK2jgryypDVOd246wmR9I78DLljKMyKBL27Si+4gdgCzppvDXYf4deTONjP0c2tBuMt3FjkIoNBCbjJa7/YPYHyJ3S8KVPgNfqXkpsIR/6wU/M2EQzLhQDmfPv4CTGbghWfxdIZtZVCTgroCZpQbMz/mSFyRHuA+i+iboY48afCVy2mjzgd3Qy/Q/TZhNb8wG4tFd/WuBj+9+l8Gt5az/bEKlCvQNO4b/vo3qJvT/KDvtg3eqSYJWMptdJLy3SaVg2rJ6FLNLlDPEVEruRJtd8oKR0cPotK9B/q9dBwmyLoclQr2dYfoD2kU+b2bCDFoB0cR5iM9wK1IdfLEdCD72sJU16zLVITb3c2JZNKRbe+1dMb+mpaYQWizIzy0QnTpIYqKgdHC9rFh17JmlSLn6xnMuZtg3gVsg/BtOaDeL/VIasg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(136003)(346002)(376002)(39860400002)(66476007)(66556008)(66446008)(2906002)(6486002)(76116006)(26005)(478600001)(64756008)(4326008)(8676002)(54906003)(6916009)(33656002)(6506007)(71200400001)(66946007)(5660300002)(36756003)(186003)(8936002)(966005)(83380400001)(6512007)(316002)(86362001)(44832011)(2616005)(91956017)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?b02RN329oppOLy7cpQYJDXnwKu3lxFUgV43fpT1UHbGSO9aV9Tl2Pi/5cGtU?=
 =?us-ascii?Q?sKOgubBwgrobeOWgytgDZPS3kpHWVf68h5Zoe8M8bl73kenD1BybEVqqISlb?=
 =?us-ascii?Q?VYMLkloZfHwOLJ6Vxu8wOp1d8YoVmLRfaQmZYHh1CXPqLMbWtO/aDDkxayj3?=
 =?us-ascii?Q?P9JeXh2roWMl3qw3ChZwueeFJtAFwvSdN8R8TsroDtbWaoGAEHRr/PL52QiS?=
 =?us-ascii?Q?TAYb1nekKJxZQKsvnskLBcdcKGCYsT1cOcetLwYOiF4y3M253jRIMqZNBPFO?=
 =?us-ascii?Q?DtPTK3SG75fTYBHe2dkW22G/zdMy6UBVsrEDCsZvV+0y6L19XT9UdEqczILs?=
 =?us-ascii?Q?rg6iZkpus4ZhSZ0yM744pOjGCubyVNKMuDrLw9HXVtnRc0qJ55culMOf9vSP?=
 =?us-ascii?Q?aR4gumGWS5XkfQtJOLORJSTPZrbPfjKqdwIAdhUzI7BacBJuAJn4CQJXc3Pu?=
 =?us-ascii?Q?HShOtEsrM5MUXzDg2EnWiGf/hMfJLkPtxr6tCpKkQi0oflpJjDZFdoJvDpwV?=
 =?us-ascii?Q?usCB/Anqzv6JSNZijmm3iDOZVgKW0UIhVj94Smiay/VrJAv41xmFzLBGSqtC?=
 =?us-ascii?Q?JT2HE8uQJlaSXTKtZra5GPIwtMBpkanbPrPR4WRxCaGc+wxHyyFIABYnTwV4?=
 =?us-ascii?Q?SF2FeYTSNnERktyzyHzpafqO7zZRSVPozrbPE2+mlmJ0kYRgPdyVy598bSZL?=
 =?us-ascii?Q?P2PWLu1mkd22VqzRD1rbL5cVOt9RLYp/4zBURh12GbANIcdL0MazVBIbuHk+?=
 =?us-ascii?Q?R4zX9EOK59Wtrd5jle/NNMEXZrgHxWhrguby5OvgqgN6BNOpZIR7JuF+kq4x?=
 =?us-ascii?Q?S1saW3sdOzhWGf9QjYP32Q3Tl7UCN2A9hJ5WrS/yWInitlmSmSuAP1e9mM+k?=
 =?us-ascii?Q?IJryvjlSq3tRJkziPYck17jPDLyliaM6hpBBK/TQ42I7JxtZLSrYvqL2UpBL?=
 =?us-ascii?Q?bXi0rFBVyLukg9aS78JjQIlfxsh6wkvJO0BOvaiKcFwi+Y0sYjcVjNqSQp8D?=
 =?us-ascii?Q?2I+Io/Rml0eCqsY5tHiGFWA3va/tjF6kpRzvVQ/G3UWogwEicPo6iwnNK9pz?=
 =?us-ascii?Q?0zt5foe/8mcc/nn6PGkitgSu5IuGzwcoe6c8Rr1FL3tdaJDAOE4aj0q9L6Vm?=
 =?us-ascii?Q?h1eZ4AwxyrdSNFK6AHkaNaqymhWVD2sYBTDZI3g9btqantkDuUjCfbHSkRPL?=
 =?us-ascii?Q?f+CYMUwgZJwJY7rKK4ByiOYYj9RP92nCtq6P9R+Xvd61Bxxvaa96grx9ZOVE?=
 =?us-ascii?Q?ukt3DZ7makze4uop57iOLP8xY6bHxSSRoFibborrG26/QYH7pvY3gix1sQWz?=
 =?us-ascii?Q?/lcp9AOTPhFHtwm2dmVI4u4J?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1BB966621066F144B30FD0142EA561C6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 995727c4-0951-432b-f500-08d8d295c334
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2021 16:13:13.9036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y202so/p9jbrYpmAz/Y/lZ1u+npir8S1pUQ9oos76mvWcNNa8o5HgS2+/0Shfrz8Lc5AbpuTC7HxWPx1iIeTCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3670
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9897 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102160143
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9896 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 clxscore=1011 spamscore=0 mlxscore=0
 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102160142
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Linus-

The following changes since commit 6ee1d745b7c9fd573fba142a2efdad76a9f1cb04=
:

  Linux 5.11-rc5 (2021-01-24 16:47:14 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/ tags/nfsd-=
5.12

for you to fetch changes up to 428a23d2bf0ca8fd4d364a464c3e468f0e81671e:

  nfsd: skip some unnecessary stats in the v4 case (2021-01-30 11:47:21 -05=
00)

----------------------------------------------------------------
Highlights:

- Update NFSv2 and NFSv3 XDR decoding functions
- Further improve support for re-exporting NFS mounts
- Convert NFSD stats to per-CPU counters
- Add batch Receive posting to the server's RPC/RDMA transport

----------------------------------------------------------------
Amir Goldstein (3):
      nfsd: remove unused stats counters
      nfsd: protect concurrent access to nfsd stats counters
      nfsd: report per-export stats

Chuck Lever (50):
      SUNRPC: Make trace_svc_process() display the RPC procedure symbolical=
ly
      SUNRPC: Display RPC procedure names instead of proc numbers
      SUNRPC: Move definition of XDR_UNIT
      NFSD: Update GETATTR3args decoder to use struct xdr_stream
      NFSD: Update ACCESS3arg decoder to use struct xdr_stream
      NFSD: Update READ3arg decoder to use struct xdr_stream
      NFSD: Update WRITE3arg decoder to use struct xdr_stream
      NFSD: Update READLINK3arg decoder to use struct xdr_stream
      NFSD: Fix returned READDIR offset cookie
      NFSD: Add helper to set up the pages where the dirlist is encoded
      NFSD: Update READDIR3args decoders to use struct xdr_stream
      NFSD: Update COMMIT3arg decoder to use struct xdr_stream
      NFSD: Update the NFSv3 DIROPargs decoder to use struct xdr_stream
      NFSD: Update the RENAME3args decoder to use struct xdr_stream
      NFSD: Update the LINK3args decoder to use struct xdr_stream
      NFSD: Update the SETATTR3args decoder to use struct xdr_stream
      NFSD: Update the CREATE3args decoder to use struct xdr_stream
      NFSD: Update the MKDIR3args decoder to use struct xdr_stream
      NFSD: Update the SYMLINK3args decoder to use struct xdr_stream
      NFSD: Update the MKNOD3args decoder to use struct xdr_stream
      NFSD: Update the NFSv2 GETATTR argument decoder to use struct xdr_str=
eam
      NFSD: Update the NFSv2 READ argument decoder to use struct xdr_stream
      NFSD: Update the NFSv2 WRITE argument decoder to use struct xdr_strea=
m
      NFSD: Update the NFSv2 READLINK argument decoder to use struct xdr_st=
ream
      NFSD: Add helper to set up the pages where the dirlist is encoded
      NFSD: Update the NFSv2 READDIR argument decoder to use struct xdr_str=
eam
      NFSD: Update NFSv2 diropargs decoding to use struct xdr_stream
      NFSD: Update the NFSv2 RENAME argument decoder to use struct xdr_stre=
am
      NFSD: Update the NFSv2 LINK argument decoder to use struct xdr_stream
      NFSD: Update the NFSv2 SETATTR argument decoder to use struct xdr_str=
eam
      NFSD: Update the NFSv2 CREATE argument decoder to use struct xdr_stre=
am
      NFSD: Update the NFSv2 SYMLINK argument decoder to use struct xdr_str=
eam
      NFSD: Remove argument length checking in nfsd_dispatch()
      NFSD: Update the NFSv2 GETACL argument decoder to use struct xdr_stre=
am
      NFSD: Add an xdr_stream-based decoder for NFSv2/3 ACLs
      NFSD: Update the NFSv2 SETACL argument decoder to use struct xdr_stre=
am
      NFSD: Update the NFSv2 ACL GETATTR argument decoder to use struct xdr=
_stream
      NFSD: Update the NFSv2 ACL ACCESS argument decoder to use struct xdr_=
stream
      NFSD: Clean up after updating NFSv2 ACL decoders
      NFSD: Update the NFSv3 GETACL argument decoder to use struct xdr_stre=
am
      NFSD: Update the NFSv2 SETACL argument decoder to use struct xdr_stre=
am
      NFSD: Clean up after updating NFSv3 ACL decoders
      svcrdma: Refactor svc_rdma_init() and svc_rdma_clean_up()
      svcrdma: Convert rdma_stat_recv to a per-CPU counter
      svcrdma: Convert rdma_stat_sq_starve to a per-CPU counter
      svcrdma: Restore read and write stats
      svcrdma: Deprecate stat variables that are no longer used
      svcrdma: Reduce Receive doorbell rate
      svcrdma: DMA-sync the receive buffer in svc_rdma_recvfrom()
      SUNRPC: Correct a comment

Dai Ngo (1):
      NFSv4_2: SSC helper should use its own config.

J. Bruce Fields (11):
      nfsd4: simplify process_lookup1
      nfsd: simplify process_lock
      nfsd: simplify nfsd_renew
      nfsd: rename lookup_clientid->set_client
      nfsd: refactor set_client
      nfsd: find_cpntf_state cleanup
      nfsd: remove unused set_client argument
      nfsd: simplify nfsd4_check_open_reclaim
      nfsd: cstate->session->se_client -> cstate->clp
      nfs: use change attribute for NFS re-exports
      nfsd: skip some unnecessary stats in the v4 case

 fs/Kconfig                              |   4 +
 fs/lockd/svc4proc.c                     |  24 ++++
 fs/lockd/svcproc.c                      |  24 ++++
 fs/nfs/callback_xdr.c                   |   2 +
 fs/nfs/export.c                         |  18 +++
 fs/nfs/nfs4file.c                       |   4 +
 fs/nfs/super.c                          |  12 ++
 fs/nfs_common/Makefile                  |   2 +-
 fs/nfs_common/nfs_ssc.c                 |   2 -
 fs/nfs_common/nfsacl.c                  |  52 +++++++++
 fs/nfsd/Kconfig                         |   1 +
 fs/nfsd/export.c                        |  68 +++++++++--
 fs/nfsd/export.h                        |  15 +++
 fs/nfsd/netns.h                         |  23 ++--
 fs/nfsd/nfs2acl.c                       |  67 +++++------
 fs/nfsd/nfs3acl.c                       |  45 ++++----
 fs/nfsd/nfs3proc.c                      |  93 ++++++++++++----
 fs/nfsd/nfs3xdr.c                       | 588 ++++++++++++++++++++++++++++=
+++++++++++++++++++++++++-------------------------------------------
 fs/nfsd/nfs4proc.c                      |  12 +-
 fs/nfsd/nfs4state.c                     | 124 +++++++++------------
 fs/nfsd/nfscache.c                      |  52 ++++++---
 fs/nfsd/nfsctl.c                        |   8 +-
 fs/nfsd/nfsd.h                          |   2 +-
 fs/nfsd/nfsfh.c                         |   4 +-
 fs/nfsd/nfsfh.h                         |   5 +-
 fs/nfsd/nfsproc.c                       |  92 +++++++++------
 fs/nfsd/nfssvc.c                        |  34 ------
 fs/nfsd/nfsxdr.c                        | 348 ++++++++++++++++++++++++++--=
-----------------------------
 fs/nfsd/state.h                         |   3 +-
 fs/nfsd/stats.c                         | 118 +++++++++++++-------
 fs/nfsd/stats.h                         |  98 ++++++++++++----
 fs/nfsd/vfs.c                           |   4 +-
 fs/nfsd/xdr.h                           |  12 +-
 fs/nfsd/xdr3.h                          |  20 +---
 include/linux/exportfs.h                |   1 +
 include/linux/nfsacl.h                  |   3 +
 include/linux/sunrpc/msg_prot.h         |   3 -
 include/linux/sunrpc/svc.h              |   1 +
 include/linux/sunrpc/svc_rdma.h         |  15 +--
 include/linux/sunrpc/xdr.h              |  13 ++-
 include/trace/events/sunrpc.h           |  15 ++-
 include/uapi/linux/nfs3.h               |   6 +
 net/sunrpc/svc.c                        |   2 +-
 net/sunrpc/xprtrdma/svc_rdma.c          | 196 ++++++++++++++++++++--------=
----
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |  91 +++++++--------
 net/sunrpc/xprtrdma/svc_rdma_rw.c       |   3 +
 net/sunrpc/xprtrdma/svc_rdma_sendto.c   |   2 +-
 47 files changed, 1386 insertions(+), 945 deletions(-)

--
Chuck Lever



