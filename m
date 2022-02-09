Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2090D4AF451
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Feb 2022 15:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234285AbiBIOoX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Feb 2022 09:44:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbiBIOoV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Feb 2022 09:44:21 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D53C06157B;
        Wed,  9 Feb 2022 06:44:24 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 219EC3aN020241;
        Wed, 9 Feb 2022 14:44:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=M3zKwbGbWVEoAOa7M0TCkUTZqYml6sH1sp4gQJxmCmA=;
 b=cNYTt5flqvagtiGNeIAHENs5EItdVBRMPOAquDAAf3t74ZeCS2Qp3RrvEHxdbXZJ1QqN
 fTX31SFtYcK5FebbgThoPZR37YbyWyhwPrdT+Y8rpaZjqUJt7qZ+fTYsC+DhAoThZPTb
 AZyzDSMGBw2/ADCbgljfSAs0BLUuBxXxNnSD655eBIwT9NE0yda2dzB7i9+Tz3i92Itn
 q0EkixPUOMf37NSSX0Mi9vQz0+hSXs9z9o1ebFH/nmxxi1VL48ANTsDiHRtl8ol6wdMJ
 07az9P6r7CduhqWNzakvPzJyr9WdRjo09Yu++lnRC2O3aKXG9EubC4xlg0G5242OMs+m dA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e366wx4jd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Feb 2022 14:44:21 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 219EbcPC003786;
        Wed, 9 Feb 2022 14:44:20 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by aserp3020.oracle.com with ESMTP id 3e1h28a8yr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Feb 2022 14:44:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=epMC/u8ShkpEFtnt+8USrQVXDskFBps6zsr9IsW08W8+Xf3v67tik8hxRpJk0/sSfBMwDdZW5FJ5Tn9GjdP4tOr/4Idc+VRggiRWl62VPple4r7i4zbsazbFEEw5//mnYpYII7d3V3z8qYDLzQtZDHJFDwCo2TrFO38qCQUv8F+S1LQZNl4drQLEeE4W++Qgnp/7p8cS/xTUb5Y168unRgpSENtn34jyVItJO0LOIgz+LCdtRsNN83g3VDAM5bu3sXjpmZRbCYVl6qFBKQY1z5QQQzfqTqRSTp6SvKdoxA4C1z7v2cY6A9urxJZYWKSndBcnfz0ALnAKJfvHAdY+7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M3zKwbGbWVEoAOa7M0TCkUTZqYml6sH1sp4gQJxmCmA=;
 b=F23Td4sEBxP5TE5drZ76ohAD0Z1XOLT4RjbXXQ5HlX85VMpqRsKvNtZWZ24KybntRl/lHrt33yTo6Nc+eJi0biavcis90o/bIHt4XahaA1tD5ZCHLHm8MdWy5NebMmir/gJQWlTNsQC9D6C55WpyrrLF0FSP/G/oVBjLolTYHH1IzmM0EAxSyYie2xIGQKxbJnDfth3Rlw1YhHvQbA6eAgbC17EPENc3UGxb5v5AYywYDZB/UGjMeaFhWVVSY0zGYsHuj+/wLpIZdHobX0fKrWRQUYv1rcPtBBu6bop30Zdn6bS8UDfLY7TNCr3y38t9TJ4VQdj0qdMH5G4HHO+QLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3zKwbGbWVEoAOa7M0TCkUTZqYml6sH1sp4gQJxmCmA=;
 b=bESvbZnSFKQdGKRXzUVEGgouDf0V1ScOfZ3grRv46rALsKA+7QatO4VlrHhy5QBjMqsIBz5ZVD/TNSRAIFzvMZJ9nFLo3fj/D91KL2Amu+wtnnSyS7rrDX5J7lJv4cDAYk265NoGqDZCNwuw1iaJVFbmjet3FsqnJNYbPReP24o=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by CH0PR10MB5195.namprd10.prod.outlook.com (2603:10b6:610:c1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Wed, 9 Feb
 2022 14:44:19 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::c8a5:6173:74d9:314d]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::c8a5:6173:74d9:314d%3]) with mapi id 15.20.4951.019; Wed, 9 Feb 2022
 14:44:19 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] 2nd set of nfsd changes for 5.17-rc
Thread-Topic: [GIT PULL] 2nd set of nfsd changes for 5.17-rc
Thread-Index: AQHYHcOEqR8vI7rQjEWafPTA3MX/Vw==
Date:   Wed, 9 Feb 2022 14:44:18 +0000
Message-ID: <6C412830-A3AA-4587-9CB7-C3E4EA26885B@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d2b92cb-4c74-4037-816c-08d9ebdaa73c
x-ms-traffictypediagnostic: CH0PR10MB5195:EE_
x-microsoft-antispam-prvs: <CH0PR10MB51954B6AD9A85AC50702BC8D932E9@CH0PR10MB5195.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BzaVsUC2ZL9FOM/QPElXf+sYJSoFujLEc/Uqpqd4ZglDnshu8WlMw361nZRMmMa2Aa97tmmz8YDY583cgPvcqopgP1yplQcXtnUYLwnQzgZ/prGgWqPh0rd9ukrhiSvvKa2yYqrsMa2jKK7Jf/FVrNQ1axiYEUd7ei2Jy5awCnNG/RqO1zDuH4Y618NpNdwx/AztvLiVj2PNqEZVJaUDfr0EJrmrp0nCNBCeAN4qAyTCsNi/r2SDc0Gf/VykIVha49vmbfqDWz/nW9tOKE13G4qGux+8JGdqQcQn5nECEnfKFxyZXL/aiY6+9xrRT5cQgtX/bT/yUjR+TyYwLsW2n5v6w2KDH4qAA5NHO16FcnKqIL4pVB62A/l4WiVL1M4GNqZvrI9eSRpoFWFSPrJj/b4QTK1exqnhFuSNKzXtvwk44AtJ1HgD0nP/uUDbIzjrnygqm4zBRO3R1kOJqitKoNakIqVm8jYNGqPoeMX9BDBWdCH8WbJHIkFc2PnYiJ5CuDUM+uKH3J0KG14T5fzEE0cmhf9sm6jxCef72OPytk74HeJ0ePsFVa9h2PIikjP/i7ywbpeBc2XW9fNI7JPiSRMq5iE6gQnrc6OOGOQkkCjzwFukC0jqIAg9obJBTEqNAaOZIUD5UhPam+p8yunMUrRJnlePS3TozrAt9HI4jato9vKHbiXhH7FZruhd6RB9DnEWqDwy/O3Ih0sxQmol70Mhk/RMiL6zt3KxjmHCxzgDQ60iDZexsG1hHd7/3Cll
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(64756008)(33656002)(6512007)(66476007)(76116006)(8676002)(38070700005)(86362001)(8936002)(66556008)(66446008)(2906002)(508600001)(4326008)(66946007)(6486002)(6506007)(83380400001)(5660300002)(38100700002)(36756003)(2616005)(71200400001)(186003)(26005)(54906003)(316002)(122000001)(6916009)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MXysY6Ii05HwG6rWH/aQXAWor3+iEPQ50M7QewjEp4T9q9ozNgE4kvIixf2C?=
 =?us-ascii?Q?y09AjHJmzKUYUspjCgi7EC+WPGLb/DnT6xeK6mGdWbUlwY3aU3oOmTyNPHQ5?=
 =?us-ascii?Q?bCJ34LAY1A4xDY3AtB9ovptEsKEyJCUegw3xPXgMcf+nkJQXgjzM9XW5y6Xv?=
 =?us-ascii?Q?2xFWuxw2CY6fwsnF1hM5dlLhhZ/2rB/tKaEX8JBbW/N8PkNyKQ0GCUuZ9uN/?=
 =?us-ascii?Q?7AeAqiHpMiLjhyflQSNGYHMZslkegLuwWcAucmraaV+L0X9rQq3eKTJc3/tq?=
 =?us-ascii?Q?+EhiMrdLUMv6phxsMp7LNsaaLl3D2kBqD1kSK2PKQhKM0GCjecgd5Wm2pPCU?=
 =?us-ascii?Q?gwobYc5N3FidMIeZf49q2KE0NJLj6pNpr6fjfS9NhjMk4qoT8aAn4UoV++32?=
 =?us-ascii?Q?NFRZMViNVOBuOlxRco1COtsKBruKVx97UrAXCjAUKKK5PPG3SFcnznn4Hz6H?=
 =?us-ascii?Q?I7WrwsPnGf11DBTCeQ447k1WEOH2IYIdXjVJWwjZ83AzxM1u0RyRptRw4tRb?=
 =?us-ascii?Q?FeLdtZvAv1gIR+uAEsVkEvTT/uh6sHWEc4L6MG4R/3XT8Qq70iQn6H9DG6pI?=
 =?us-ascii?Q?eHZ9yuQwgtszkoTXUq6xj+3DldB1ta5bQeYuEtQjqGjb8FFXapXc/vKXQoGI?=
 =?us-ascii?Q?p9m7b0JO5RVyL1CnqQc3goG9s2jJdiWdNpMHQgma7il/F8YaJ0e1H5paIThb?=
 =?us-ascii?Q?wxEmfg9LrO+NvkzG2OsYSn1WKuQtbkcEb66EYtcaD+Zi8QqAtgz54q6rm7xs?=
 =?us-ascii?Q?gPXu3eEc9Lykjjoo0pupzr570Y08hnnYt/OfCd/JQXMksVPP1x6V9JoPTRsJ?=
 =?us-ascii?Q?J1c0qeKX7YdHL7qEEKtelFY/nr7i0nWZ4j1jIf0NWBABqBRO3hzG4zFZYG/O?=
 =?us-ascii?Q?q59e57RCWp2WmRmd6aHGdY3asQFhSfEGbnfC26TdXMSJC3SsBciJSnME5x+Q?=
 =?us-ascii?Q?rhVQ1/duPKvXfI0arcAyVpId/ddIR5j26cx5pZEXLf2WGzNSI31zUJxLLrpL?=
 =?us-ascii?Q?vciWcHJSyXWDgaI+9QmCtuf22ErMJQmH+Vx2jX7DKQgq6kPaJGI6wSKfrjWs?=
 =?us-ascii?Q?SN1PEIiejwE6s1YrwSIVbcuZfNJt8Yxqc+0zX48giWiHNUeX3efZQWYk7i2v?=
 =?us-ascii?Q?fkDccA7BYuKp8q9lnliytk8PMFKUAEOESi3JBTz4Xhy7ZMYw056/IwZQdTBY?=
 =?us-ascii?Q?zCDC1lDFejuwYnDVf+jDiMkqGauJGy5cTFO7Ec/dSU9zlF1Ey1bxde//udM0?=
 =?us-ascii?Q?siJYsq067axJsL+TlMSYNMK5ngrXIzkv3QZUhOCRxBrmekRopcnJ+gxKawLA?=
 =?us-ascii?Q?mJD8nXXmLLhefNaaUmcSU3pxI9zP9SWeG7OTbW+CAADZdqrJ2UcS6CJ80dVa?=
 =?us-ascii?Q?2kCjsaLEZ6vf2A5Ni9jJy2ZNNYvquPkVTnIovBjdv7njzitFE6N/Hflao1sM?=
 =?us-ascii?Q?Z9L+MGHjXpovS6WRdMMbN1t04CGWFYsMoqrob2kp+UolM3KekdFEGpfiHE2m?=
 =?us-ascii?Q?1R6WyD3GAruxL3ienO8R5zhM5tgbqyptKX1znhbbn2FVwYnTj1M56l1jCRkS?=
 =?us-ascii?Q?hOOs4NjWvDVOCyBGNR1/wTQBdM5g1cBf7gI5VZHal6XV8bQVUJGFW8c/NKrb?=
 =?us-ascii?Q?0mJbXrayLZ+luIlshRCF454=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1F80491C8DDAD442B698C35A42A1D8E9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d2b92cb-4c74-4037-816c-08d9ebdaa73c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2022 14:44:18.9856
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 42alfJAFDwUipv8PDBKqMJiE3/95AlYCHPq4ZoW+jDkPvKLTyDv/rntlvzDk+CpwlVwJ8IOVFr7P1bG7dwPmNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5195
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10252 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 bulkscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202090083
X-Proofpoint-GUID: hn4FIT2hz-Bpg_VWtSGH3hZw28E-rHVq
X-Proofpoint-ORIG-GUID: hn4FIT2hz-Bpg_VWtSGH3hZw28E-rHVq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Linus-

This pull request contains fixes for a bug report that came in
at the end of the 5.16-rc period. It took some time to develop
and review the fixes. Regression tests were added or updated as
a result of this issue.

There is a crash fix and a fix for an unterminating loop between
a client and server in this set, so I'm sending these now rather
than waiting for 5.18.

These have been in linux-next for several days, but the commit
dates were updated this morning because I forgot to add Cc:
stable the first time.

--- PR follows ---

The following changes since commit ab451ea952fe9d7afefae55ddb28943a148247fe=
:

  nfsd: nfsd4_setclientid_confirm mistakenly expires confirmed client. (202=
2-01-28 09:04:00 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-5.1=
7-2

for you to fetch changes up to c306d737691ef84305d4ed0d302c63db2932f0bb:

  NFSD: Deprecate NFS_OFFSET_MAX (2022-02-09 09:24:40 -0500)

----------------------------------------------------------------
Notable bug fixes:

Ensure that NFS clients cannot send file size or offset values that
can cause the NFS server to crash or to return incorrect or
surprising results. In particular, fix how the NFS server handles
values larger than OFFSET_MAX.

----------------------------------------------------------------
Chuck Lever (7):
      NFSD: Fix the behavior of READ near OFFSET_MAX
      NFSD: Fix ia_size underflow
      NFSD: Fix NFSv3 SETATTR/CREATE's handling of large file sizes
      NFSD: Clamp WRITE offsets
      NFSD: COMMIT operations must not return NFS?ERR_INVAL
      NFSD: Fix offset type in I/O trace points
      NFSD: Deprecate NFS_OFFSET_MAX

 fs/nfsd/nfs3proc.c  | 19 +++++++++++--------
 fs/nfsd/nfs3xdr.c   |  4 ++--
 fs/nfsd/nfs4proc.c  | 13 +++++++++----
 fs/nfsd/nfs4xdr.c   | 10 +++-------
 fs/nfsd/trace.h     | 14 +++++++-------
 fs/nfsd/vfs.c       | 57 ++++++++++++++++++++++++++++++++++++++++---------=
--------
 fs/nfsd/vfs.h       |  4 ++--
 include/linux/nfs.h |  8 --------
 8 files changed, 74 insertions(+), 55 deletions(-)

--
Chuck Lever



