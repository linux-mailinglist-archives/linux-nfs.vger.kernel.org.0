Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 017207204BB
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Jun 2023 16:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235350AbjFBOmn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 2 Jun 2023 10:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235298AbjFBOmm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 2 Jun 2023 10:42:42 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C734DE4D;
        Fri,  2 Jun 2023 07:42:37 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 352CwE7d022517;
        Fri, 2 Jun 2023 14:42:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=BnRE3zbLKHzKYgom+fLD5Tg/crkfZmVOU/unZkASHZ0=;
 b=BLZoTvYi+GP0doJ6W71C9pYpx1ZI2Jk39i+dzNkdI+il2FF9mb2ellc9OVyzv35QB85y
 29WgbsWkvWLcZJ0WkctYkGdbdCAEEd5FNA7YvaN4f9NNPaT/mTTUgJn0ir8Wi5/uCYqS
 jUXPmygOJLVClxzIq9OvqSm9j17yXCecajdai/nsnN5QN8hZQEWHH+dnJqcMNf/M4iWB
 Ez1eFrmL4AVpeSgga2Zm0J4U+TTU6+G860DfUFXsOEIwODmQJDI1YD9nvTSwBeNnfm0n
 hgMJGQl2bgcQW5rGqX1NS4EsQrK2Jocd2a7emYYiH6r4lw5xo3kasQYKnhWdvd6Cx0uZ PQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhwwjyw1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Jun 2023 14:42:33 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 352EAIWI017223;
        Fri, 2 Jun 2023 14:42:33 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qv4ygaqp2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Jun 2023 14:42:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g0l8udcC1iBt/Sf27dHLvZsruwANHj9OsWmEMivYsatSjmsLzWA7faqJzgSA0zSGzCI3/vxFiRExDWt/Ay5aPEnwHZuElLaFaeAr1WPHHvMCvG90uucl82TR1PlDwRoxToo4PBXlrQX4NCteSBdbDwquGNzg8eeBexNi3MTpWmHRbu4/GTTgXnvyLfCtw5r4byGRp/LBxtFV2agHOjqgKvAb3oPunPvdkrloldTcaJ+Kh7eq9EajfEwak7W+W+XTsd8UBs4k9WBSXeRNMyolzOFAYAUIAUlLrwikaOPp3c5HkuXGIQNyaa8gEjOzORqjIDCqlIlpI7nwFHh2mfmkoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BnRE3zbLKHzKYgom+fLD5Tg/crkfZmVOU/unZkASHZ0=;
 b=OvYEfraTqyszybOfByToYuR7mlPAEd9L6pIfXJ5S1fhrm9l9IzKG/LeKtcw3qXXiEgVH8f6wM7j9E3+FIsJo0Fa3+4mqs/OWqHgdJCEoBxNttrAouWbg6q+ilqwOMl+YMHoAAo964FFYM16+rN6svSWUaCdFq748xd223HlLaIf/5e1eRXHw2iWJPmbLndpO94MWGMtPwhI2Fa5+7pq7tv+wZoY40DvhUx7TxCMXChs7z+nrIyKdGN7UKnLykR4ZswboOK5S6a4r7Hh525WsPA+n8y6QWkPs0PrGzReZ1PX+zAfWXxQPROsZP80w3eytmH3YPwtqLeEwMHq8UTEnSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BnRE3zbLKHzKYgom+fLD5Tg/crkfZmVOU/unZkASHZ0=;
 b=CXSyjk/0nv4TBj13iSX4OGM2XJ7QWJnBnsMb3JYw5iphmGtwI7UqrNyASjDDEJcNszjws0JHXDoRahWveubpDqZQC9+xWHQnrlghAAULc1x1Ro3Mk7HZuCQQGyU9zAmuz+a23+A992NAf+wG0ybRJwHcJRbK+hNEMjjNTNNb00I=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB6414.namprd10.prod.outlook.com (2603:10b6:806:259::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Fri, 2 Jun
 2023 14:42:30 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6455.020; Fri, 2 Jun 2023
 14:42:30 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Linus Torvalds <torvalds@linuxfoundation.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
Subject: [GIT PULL] nfsd fixes for v6.4-rc4
Thread-Topic: [GIT PULL] nfsd fixes for v6.4-rc4
Thread-Index: AQHZlWB19MyXWCDFLUasq7rfCSAgUQ==
Date:   Fri, 2 Jun 2023 14:42:30 +0000
Message-ID: <10156F3D-A4B8-4462-80EC-65ECDECE7B44@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA1PR10MB6414:EE_
x-ms-office365-filtering-correlation-id: 47d5184e-5295-4906-6161-08db637797e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w1r8AVe3/u9eD7ZbISXNpmqrrwZgb+fCiLUvwMyJ3lyn4zDfIAIOwsLIalswmWaP3pZmU+ZWXLkvqSq9pJCTwUrSzbNxNSVz6ZNrJqT8K142YA0gQz3UX0BskLUMhcKzhTY433ffp147cJ0gHJCCwhE/guF/1Znpgoj2GNrIyIjj1ROLQfTePyzEHLLUNUndPm2JAi6TyKex24nmkScdwLH6Wvrj46qri4/mLyovuJrnVf++1KvC3ZwZzt4mGiwko9kcbcZgsGJarpCgKiDUVZr5BiYPN39D5TRJHbjoHov5Coud0X/GwgLQsRPySU67P5cFfzpNrKJZO1O3DlFfpqUBGE7F8Asy04b/tfdfMIUnintZqdTGRPjGfWb/AITZEW5FHOmRzJ7YXtnVGtYQAcnr0/3545lY+2TBi5Jl4U7VeW2t+UG4e3+tt11JjR/gId9uYMFLF+eeeWglfuV8Latm/hh9um3cVg0pyrosQ3Ia84AFpY96sI64RpmWPE+o+cXLLoaOoWoSls4i/n5Ld9Fs7uNcFkY964GnZuFNcw6/81fzZvCzywA+kMoT/hBzx3UedSWIH8tfl+RTSIvcMJSA61BtG5yyqfhsMKccO3/h2oNjRaKRikqRolbvGHMrXY4ncJPVUwrzjndHohYvog==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(136003)(376002)(396003)(346002)(451199021)(6486002)(966005)(71200400001)(478600001)(186003)(33656002)(83380400001)(36756003)(122000001)(86362001)(38100700002)(6512007)(38070700005)(2616005)(6506007)(26005)(41300700001)(316002)(4326008)(66446008)(6916009)(76116006)(66476007)(66946007)(66556008)(64756008)(91956017)(8676002)(4744005)(5660300002)(2906002)(54906003)(8936002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qeKALrv/1rwh3DQMzjJS675URDwIgtsmx57indoHDkAIhnMpripUFYhVmvg3?=
 =?us-ascii?Q?TWSYixy1Fx+fOqTeadqy5RZ6OCbmURgLogPB7BtFTQWk6H920neMPExfJuVU?=
 =?us-ascii?Q?6WWLdFBs2Ftr373PlgYZx6ssbdqCdOtmOs8U6yxy4QtlN10uUhowPpKJhFeL?=
 =?us-ascii?Q?RKJQ4pkjA4H3GXpLA3goeDErNKccM9GXETfRuwF31D+pTicWXIUUF9EbMQW2?=
 =?us-ascii?Q?5YB57JxTYhkc/Y87l3lCvI5A/fvCWA/m/YiRbV4iLjE22ZSQ0eZYKsqk+rOe?=
 =?us-ascii?Q?FLe2oaslWPxuLLL89EWvBw2kNlXHEar1/Q2U6JSJwStGvD7Ddls3WjEBfsD+?=
 =?us-ascii?Q?KiIvzga8dpdGq+DqWDiw3Q/40pfaolSsZK4WG8KeCO1EqGGlNxIjYlRRFm2q?=
 =?us-ascii?Q?oRsy5WyU6MvnV+Pj/jwlaj0y92uLwww0LkVwcZOsz7Y9NOQWX392InaWvCCR?=
 =?us-ascii?Q?Ep7FewXmk7/Vcah2k1wJMOPt0Ua8xIB+KXqyaosb/ozrflnbrta8oYh6WrRH?=
 =?us-ascii?Q?QlmpvbKtMtRc2ER6sihKDRjhrW3knJgYkrRiEd8NIK7MFnoZ37gKB8CFS6rH?=
 =?us-ascii?Q?CNZNsR271/o8h8dgqHnWODSMMFj/jNPWJQaRpuBDSu9vrFaGlsXrzOqKplru?=
 =?us-ascii?Q?zO4/l2fMYVWCcla02s6phu1KH1610NibKjmcTUzmxEYSIAEWw76hzW3NzbEa?=
 =?us-ascii?Q?Pcr3ejuXOzUWHHxOmv63AIGpJbK6pXVowhj380Mtq1emPT3ak8AtOsRTJOtG?=
 =?us-ascii?Q?G+1tpykyD24kxyLzEWLma3tVVg0spAi0QXPUoptMAzv5MZU5C1UCHZw/A6Kd?=
 =?us-ascii?Q?mQqzHCzNpxe0gss/F+s3PjSjUVco/atjJDNpZEV7PNNNQPj0XsjzWxT8wrm7?=
 =?us-ascii?Q?AkmlKG3LD77NnWBuVJQBeiXzitc7oKPz9LfVcz1EQPFMqN2JVXPME28JyzHb?=
 =?us-ascii?Q?gefpPVNtsRiCD+/LzpIG/r+8Lj22kjtJZ7p51MLsjZBCcEFTmivpQcsCVRQX?=
 =?us-ascii?Q?jyRN6ojyZOJg6dWfG6FIJW5desVt5/OKOREjS7gRQ9cGF8+4Pnpvr8uaab6j?=
 =?us-ascii?Q?4t9pf9dW9yShZZwhgZ9oK6DLo+Btsmew6xebPkVFpKA9kFyBEtfGMbceqXva?=
 =?us-ascii?Q?/McyR1dJMZ4dsIEVjHVrI8nUGQ62XSd4WpQ+7i7R2bl+0e8EDt1Q95SbTgIg?=
 =?us-ascii?Q?lCnmD/r4YQ+HNtk1bc8pyBho86MzIJhPONbGKhLsEbDBzetOCUblTXdfAVFv?=
 =?us-ascii?Q?GBAOs3bNDzQAaO8Zc2bE0SFpNRE34LtzUXrTpxwFZFRZmr5fBzpP6hvrOCyE?=
 =?us-ascii?Q?iDu/Frvvn2P3k3qwXx2AN/P+iC76cwJtpjN4GXGnefPEWoUc5Slv0NCtR98V?=
 =?us-ascii?Q?GLpWksNzxX8ypIV0XcXy/t5jgPAJ0WDKWM93ea/IANaSOyi9W8/pMafjc/Go?=
 =?us-ascii?Q?hs55bMtihekm/wBiQ0AozHWPnmx0FiBuxkP+fO1xEuJocBbqaWtxIX+RLb1P?=
 =?us-ascii?Q?VNeACxghTAIcabfdAqPbv+DE+ecWWwRb0Ic+kwrUcB9+IcwFjmxSJ+ba+bC8?=
 =?us-ascii?Q?kdTyfn8staZqeSSiNzIDL9Zsft8jr6zIgp84xLgj6XuYLehX8zMncGOiSR/F?=
 =?us-ascii?Q?qQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <23C56A737672DC4E944225DFEE3509B2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VTYyg9P46SZnFgtbMga6cUntdjLxXLlNmzHtZ2C+s55u6rFeKxDshhD2tE1pMUGwuqEs7mRDKZWNzkZfMwSylCdxC1zgJ1MeiDXAWAQZ4Md+0Ha/HV1B+4ruEXkP6kZXcf8BTWPR//b6c7HBbfmRh2+yB8g1NeZ2mDyBvX16CSGvXQhYqcsw+fFVmafIw/dtzzvdNxEZAgZNNLsgU8iBfdpoRTMy12J3welSdhOMKiWG1pxaPcMrTRNzH74W5+qSNIwP+rIYXa3M0Lvw0dFKz+1IT/dZZi5ZLUpbBg0AAIkiBsZf42MwYPn87vUVS4P4t9ckiQ8Hbuut/cljsOIGnJpOJD1QdSEEkFBiq2MVXdYrkUSl5IJMw/uBhKqTnFhJYV2WgKJmCmEKCbw9g0f8/e1KRCPPJ8zL2RHp6/6fFPD5FXz9bGQhZAIDyPVn4UflNUMg1eL/2tcbsc0/K2UoqW+IJymr6S2bU8+nmhgDP6ogjlJpv8pK6tPrCv5qKF/NkxSJTVu9UUZDh2ZZOnxlf58tInV0cbisZd/32p93iuKbYnT0Xo5cFwE3HWNCZFExkEVZFmdBy8CRrZ4KxJXAtEq5YV9eqXZ3ANeSupdA+jVq1CF04PIAQon8KrmMhBr1urMSazFFu47oNnv5TrO+ilUGdosdEHrhrytKfuf94JlN8dp5s3tZUybaIB39vl5sHkIO0de69nUDktESRdFvceNhvoPpSAs7+Ue/IuqZibETPDMCxSHAr/zMXG7lwSHiVnT1cgJyzsUFCvWQ3w2g06Xe1bnp/9z5HHDEZwQgpJyhRmvyCwT/MjZGi8mDgGSNUXVJmZYXDcc68J+8j01kVg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47d5184e-5295-4906-6161-08db637797e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2023 14:42:30.3809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FPYzqMJ96p0W6n4Uqr14dVzOWggkpktD55pgYu2tAe/N0fAnv/GBlOeZSpm6bpPwyuCFoEU/WfBzijXWP8/nQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6414
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-02_10,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=881
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306020111
X-Proofpoint-ORIG-GUID: wg7S9QumIGEJvsevQj1NrNmAJ5jn3Nj2
X-Proofpoint-GUID: wg7S9QumIGEJvsevQj1NrNmAJ5jn3Nj2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The following changes since commit 21a3f3328972bdb774c62b301a715b5cebf03fa2=
:

  NFSD: Remove open coding of string copy (2023-05-15 08:03:04 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6=
.4-2

for you to fetch changes up to c034203b6a9dae6751ef4371c18cb77983e30c28:

  nfsd: fix double fget() bug in __write_ports_addfd() (2023-05-31 09:57:14=
 -0400)

----------------------------------------------------------------
nfsd-6.4 fixes:
- Two minor bug fixes

----------------------------------------------------------------
Dan Carpenter (1):
      nfsd: fix double fget() bug in __write_ports_addfd()

Jeff Layton (1):
      nfsd: make a copy of struct iattr before calling notify_change

 fs/nfsd/nfsctl.c               |  7 +------
 fs/nfsd/vfs.c                  | 10 +++++++++-
 include/linux/sunrpc/svcsock.h |  7 +++----
 net/sunrpc/svcsock.c           | 24 ++++++------------------
 4 files changed, 19 insertions(+), 29 deletions(-)

--
Chuck Lever


