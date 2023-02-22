Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B714669F7B6
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Feb 2023 16:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbjBVP1O (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Feb 2023 10:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjBVP1N (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 22 Feb 2023 10:27:13 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFA836FF0;
        Wed, 22 Feb 2023 07:27:11 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31M8xt0a030140;
        Wed, 22 Feb 2023 15:27:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=tXjtgBtUVj/eW8hNHRt14p2M04yfdPZ1DN+OGy/EpRU=;
 b=Td2uCHWtX91VxfsYRD+cB5w1ztZF5Xcot32ev9UvYc79bZIvQDry+fgATuVq2a+FSW7n
 TKOw6mIH9rFQJkwxpSnmA5g50zFetzhOvTgfQVFjSUCf4d7Won46vkZ4T2W8s1g2LM0A
 cELE01ae2E8kls0eih3rAOKIyxvhOLzHTem1SWVgVoAv3ievMUTzVlAKMo/rb9HeOO/I
 ssPzSVf9fLttLyC39aB5qaxA3Ko2TtgFoBzMAtDCuDuWK6I0P2+C0S97auBy7e7LLJ1I
 Qdhd7Zzgin952LD/5wgiy9FSw/O9NLu8Tp7pf2AKB+Iof2aaEDPFDs2mA7BPxczUPkzo sw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntn3dr6hs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 15:27:02 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31MEfV66031268;
        Wed, 22 Feb 2023 15:27:01 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2047.outbound.protection.outlook.com [104.47.51.47])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn46pevd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 15:27:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JMg8Nb0R6DzmDOgFM1NF/GgJ/gOXtGMWfkDPi9Uqwy3jTnyydvqtRkOTtk+PdiifqzuI+iGVHTdlzViPGhwRfXl8e/CFUgo9jTMed2ijuPs7Q2xtgUUl/a9MlZwATuntto2vJLta4B/RXKmWjUNYzSilcI0HzdrleXk+Tg7IudDHzid3Io3ow8/P2WnIt27bnFSsuXwdHzhHXnDTeoS84gVFX43tSLyQUpYXVYME+3xW+b2dAjOwDbpswDZwApkZO6+AV0OhHth8cnzmcvB2CKRFmSleh6kvpWvjI7OIO/IOoTdNUq79QrmrpNRdd6fTQIeN48P8WtLCwYKJx1zlpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tXjtgBtUVj/eW8hNHRt14p2M04yfdPZ1DN+OGy/EpRU=;
 b=WJ3ULKSBbZ9WCzCr0+bt3K1SpH9fsNWS+qDvq5OzkyV/UiWAsjMGMxmcbY4GEt6VXYnJhHjV8GNUN2LZXGOmtNK+r79rpwKQv7Rs5h3otfwHmBxYzjSOqhvXJczYZmaeova1/JCTJNuLX0AepJWaeL5uHRPkiYzgZX1DYnnF05koDzmQRqi1qJUEbvnrnGH4iNd9drlVuQd3d3a4jRCGrvj5JFLZL/FOiObQaAJutWtuKHT5MiK/M0Tvc9ZuyX3oy8dnIiiCdC18DsoAJ8029z+km3C1Pyy26p5lBJ0eInHwNnfIVCduoibEkH8DQfp8iTesX6cL80HyKNBCAvhpeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tXjtgBtUVj/eW8hNHRt14p2M04yfdPZ1DN+OGy/EpRU=;
 b=VIXB1TMUM5ZlUiby3SBKIxccuZ5QSUKEyYcM6V9/dmRv2BosFdf2F+P+D8Y7UfYT3R7MjnNxoTZgKcM3++rLj8ZeYsmvFsktA+fcWM4hCd6ZeTXWzuC1BFWOjPV5Iv9NjA5VUXuPrCFswT7ut3dn5yHWMvjZFJ5I/Fh1mfOcEag=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA2PR10MB4538.namprd10.prod.outlook.com (2603:10b6:806:115::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Wed, 22 Feb
 2023 15:26:53 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127%7]) with mapi id 15.20.6134.019; Wed, 22 Feb 2023
 15:26:53 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
Subject: [GIT PULL] nfsd changes for v6.3
Thread-Topic: [GIT PULL] nfsd changes for v6.3
Thread-Index: AQHZRtIXzb0SrrhwsEq286LqFoyK1w==
Date:   Wed, 22 Feb 2023 15:26:53 +0000
Message-ID: <C34C632C-9163-4825-9E09-9845B0B7DFEE@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA2PR10MB4538:EE_
x-ms-office365-filtering-correlation-id: 51c88f67-fb4f-4ede-f244-08db14e939dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QTuVCK+pOncXs6Uq34+eDnEoyXoe93pziF/HKPRnho9mbVmT/dl7EpqugA6eRBRHDVAK6/QRUX7bv+GwDLdK0GtXmHekbrSUKseVOS9TZLfrGK1Nra9Y68fRKfOk/IVnkX/YUknKBJ0inOyqT2lV4G4xF39XrGKv1kULKUgIDkrQ/ai/UowCvdunShhmEK+59QZgyovsHpBe29QBZkHOaHjPRNuviOw5rBJSlvZrNT7fDLT9aIa2AS96KeBJGk/+CchDVwkNMJLn1lVz095uNJ/TJCCZvuwQcNyHX5sZ9+xGExpLwPR3AofwKd3QXT/cDZjVVRda+wB298CTu6RKaLZxVVtYAv3lCwD+jcG7gxltKF6xJzCbHHwuoFDv+ttZb2eQvKTomaGjphgYXdQMXwafE616S7f8ZY8YeTAoHBSy74Gqm+YCiQFlU/sUtX5c3aXy79vzAGSvpwwEHpIStOwXGclriD/Eun+1vtgWMhwRxLQriHNh0NuGzmzZDPBWOHJk7L5ZGCGQA/Td0yaeyr0eLrcScdL1i3KL7UDVaU5OfDz0/DntwMxRvsy5pPkbqutjBPB8c0Zbggu2uoLLVUUuQgYx3voNKaXfstoBmD8L+CUOcYmTJ0P2lfFQ4J2VLEEEwNz49m9/j46Zj3B8ShQsaw+om1ysu0zg4o9nf6CsDbR4R7/P+yieWydX+EFAngC/mjcwysr2MTnVVcN+0f0hP4U6D5HPvjLpBIVTNHY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(136003)(346002)(396003)(376002)(451199018)(54906003)(316002)(41300700001)(5660300002)(26005)(30864003)(478600001)(8936002)(6486002)(33656002)(64756008)(66446008)(66476007)(86362001)(966005)(76116006)(4326008)(91956017)(8676002)(66946007)(6916009)(38070700005)(66556008)(2906002)(71200400001)(38100700002)(122000001)(6512007)(6506007)(2616005)(83380400001)(36756003)(186003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0vBJ9Q6Yv9ucfCpffGcdVkJC4i/dbOPSwVP6EawTbPGFH5lOJf3kBThUOW7p?=
 =?us-ascii?Q?+7RBQ2t/08vYNJQUBbiHVF7QSgzcXbi7DtIjJykNYaBq09rKZCUcRyNVwQ8O?=
 =?us-ascii?Q?BQm3OcvKhXHbXIVeXQuEJhiAn1M0WRCPfjHVPvwlHsMwBQycXorLSJdF7ObV?=
 =?us-ascii?Q?yU3vi5gJDk1A/6SlYKfn8/Aa1X5dqwXzQt1vdUrqFwE5+RjUhJ46oXe2h3nP?=
 =?us-ascii?Q?NQ/jDdai7TZ0UQ93QNxwK9shArRo0QUza8+wHCvXP7JDNT38bfLEyA2lFv6+?=
 =?us-ascii?Q?UeUW4J/IgRL+R6V2z2dhOcyM/i9tP//mWxG0835V/XNncJktRcv8lRuMAw81?=
 =?us-ascii?Q?j7DqgH+LLDxxdcByKTii/7QB5TLpHzLxltNrZbSjNIzOQnCKjdWRtJfHsCY4?=
 =?us-ascii?Q?70AyPm4ICXJQg27UNEggGaK2SjUHqIxjpzwGGI4V8JBDsOaz+p37eYHHhkCK?=
 =?us-ascii?Q?dzSi06gRfV3nBSkBbfkbX42N2pWql9LEZUD+Hu/HIssMK0DpJgyT5QjfXpnY?=
 =?us-ascii?Q?2izYKQWSqzsYyYiXwT9BvQW0imZXa33cKnfYFsywLdoEtrxe/uYiiL0Gcrtt?=
 =?us-ascii?Q?VULdpwcrlgoQjFHvLpac9dvm7romBzQdSgQtcfTf6WtzDZRSIWHKAzgkaqyP?=
 =?us-ascii?Q?7MqULV6lKHHNmF80Pg+7RDREBAJEAizYZQVK0lA2Khm9RE2zpsFhDYPfeEHc?=
 =?us-ascii?Q?RRiPGIZyc7dYWKsSPFQrTL05zkyDXwNbRP668c2puLunvPaPDIwqzmJaxSeB?=
 =?us-ascii?Q?XO3Yvq2O8v3UFoxSD1bHSlyQs2VGcAnQp0ymDbJpNmhv12rYtPPMZz8JelHY?=
 =?us-ascii?Q?CY3AyMZjfsCNSzxecu+Ojl95z+oYmH3tvp5rgPRcCs+ZGA+WQHB0NT4iVq1s?=
 =?us-ascii?Q?fRRfza7ek5xLTGsmG583tmfVHu58CQzqlUUIAnRljOghJwb7qQwXGpuyaHWZ?=
 =?us-ascii?Q?o+pqgeM9cNUnfM8k9xpfj7MpCS0hCElg7N+pkgBsfaa6ftRN7euw7cwznigD?=
 =?us-ascii?Q?yb+kx6WiL/ryfdJLHqHcRnyh/ZVvfaHgrB9aafJ4Mbc+8ti5uL58+lrS/hOj?=
 =?us-ascii?Q?a2Dty9T5DhzlG76yluxFQUpMUnQKA51v3eJQTc56to8fiJDQCpeJ1whmC+gG?=
 =?us-ascii?Q?SnEsevlFNe/tpnTfUq/6g9wdL/bagt0a3Hv9dHaBlnGE1WCymeBp/I/L8rIA?=
 =?us-ascii?Q?aklnYo0D7Fvkaa2ALO8MaUmLTKvoYg+bBWGoI0XiCEMOPwcw1hW2grPs8g4Q?=
 =?us-ascii?Q?e7+iWlL05IVma8T6O73AoeFy02SmE9dbydxZ/XEnwF8P4h76yay8uvqQu/Yj?=
 =?us-ascii?Q?XUHxu9L0nOGNzZpGPXxkbs4hG66se19xF+kAs83N2m7EIWlK4GfDos8WSYjI?=
 =?us-ascii?Q?vhRVXQl+zOEx0Vt1QoJIC6IVKHaWy3ybtnaS3d8pRO093jV49houhTsskBpC?=
 =?us-ascii?Q?/6fj+A6Des6CzWI4Kn7SLyRuOhEC6PbCyHbQ+KxT2B6SCojyO75gOfjoGN7O?=
 =?us-ascii?Q?Qmcwu30At3I3VpiempioLbVuhFPrf7YY7U2jfG9T87yY2ppVcBIgVaM77Ht4?=
 =?us-ascii?Q?zw7A+G+1FiTE+KEwYhUzQdIr3GFZQb2jPQVSf5G7lnmGEWQm2zlZPfGuyueo?=
 =?us-ascii?Q?GQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1DD4D507B3F04C4E9247517FC1FB9FEB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ZgxbDpkMpuraSrzAxdVKg/gKb9XQqvpn5Yt+Av4eGR0UXLGgmjctezaNBAVpk49kfALObwuPjpd5u3tb31GJWXYcNimnGt7Ct76v5ze9vpjw1O9ffp1CV8ja24F90FVdoLBcYrb67vzpFWp2E6sCCTCDXeFe7yI5nf/1nEAI4F6SJf4q+aYB7hMZdOZR3rHzu67E6KFU9sdtBv1kRB0butTdBOJqVZsi7JXG4ToGpMBFMXo60Hr2OJk0zQhXz6zmgkRq7ZuW+TyhfEyrnBZVTqpdTOPNKIFTgjJWSYcbVNvQHpqcoI0XBg2A7gzdtwFKoFQK9tKU5w7CtcvWl6UKB2IxQgUyukZcsAifTBWM8qJ5z0lMJqLDhd8fpSEL6oNF/XkmNw3wkPNr+it8bHYlFb09Xk3KUM5vprjOt57eg8ffL+dXlCcy5c0w64RlbEU/UOfeLqHAx9RGodlUIDU9MhJRStNriLm68vz/ugFb7+3UCAQ+bOgBEgrMnlRRg9JRBCgmg3HB41OYQkN4IKRKaJ588WGYO4ZTbxeOIuRSDIN7/fsyiRPmZbwohomvzhA6fIsc/8qrYwLdcxSCrGZVD/4AZgjLzM6x0zRcsvYwq6j4+8eRB0kdXc86W4uJ46PVToagnQVhaFy9MYcZ2Yf9fHrOAW7G83DA5rpsrciip2v+WtcnysRcYLSjBnx1n72WYGM88nIj4ldM0h4UWz1UOc54qtqb+sNPa+gnhPLZljNUJ9xMbOYhRc2Vtk2h6UQcb4+WDXiPtRLE/pGx/lDuWfDZL2zhYocMFclteH6W4Uks2kVjlY+Rh/xiMQCEV3KfYDOpgUHX33YmEWyICFIKMwxooU6+sH57qllkzBZiIak=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51c88f67-fb4f-4ede-f244-08db14e939dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2023 15:26:53.3683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4GiDVfSdGMEpvcr13aTHxHzP+8oIMwY3jkakdVZhhz/HViPedT1A+BLCvkgUnnqBPRcDGQljWVVs6Ays4m8kXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4538
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-22_05,2023-02-22_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302220134
X-Proofpoint-GUID: TW7Si3EX9PoNSvCDj1dIeYMzCBLuTI71
X-Proofpoint-ORIG-GUID: TW7Si3EX9PoNSvCDj1dIeYMzCBLuTI71
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello Linus-

Two items to note before I make this pull request:

- There is one regression with exported tmpfs file systems due to
  a change in the Linux v6.2 NFS client. The consensus is that to
  address it, we will need to implement stable directory cookies
  for tmpfs. A plan is maturing to take this project on.

- The reported issues with the NFSD filecache in v6.0 and v6.1 have
  quieted... we believe NFSD in the latest 6.1.y kernels is now
  stable; likewise for v6.2. In an abundance of caution, I've
  limited changes to the NFSD filecache for v6.3 to only bug fixes
  to see if broader testing reveals any more issues before we move
  on with further enhancements in that area.

--- cut here ---

The following changes since commit c9c3395d5e3dcc6daee66c6908354d47bf98cb0c=
:

  Linux 6.2 (2023-02-19 14:24:22 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6=
.3

for you to fetch changes up to 4b471a8b847b82a3035709dcf87661915c340c8a:

  NFSD: Clean up nfsd_symlink() (2023-02-20 09:20:59 -0500)

----------------------------------------------------------------
NFSD 6.3 Release Notes

Two significant security enhancements are part of this release:

* NFSD's RPC header encoding and decoding, including RPCSEC GSS
  and gssproxy header parsing, has been overhauled to make it
  more memory-safe.

* Support for Kerberos AES-SHA2-based encryption types has been
  added for both the NFS client and server. This provides a clean
  path for deprecating and removing insecure encryption types
  based on DES and SHA-1. AES-SHA2 is also FIPS-140 compliant, so
  that NFS with Kerberos may now be used on systems with fips
  enabled.

In addition to these, NFSD is now able to handle crossing into an
auto-mounted mount point on an exported NFS mount. A number of
fixes have been made to NFSD's server-side copy implementation.

RPC metrics have been converted to per-CPU variables. This helps
reduce unnecessary cross-CPU and cross-node memory bus traffic,
and significantly reduces noise when KCSAN is enabled.

----------------------------------------------------------------
Benjamin Coddington (1):
      nfsd: fix race to check ls_layouts

Chuck Lever (101):
      SUNRPC: Push svcxdr_init_decode() into svc_process_common()
      SUNRPC: Move svcxdr_init_decode() into ->accept methods
      SUNRPC: Add an XDR decoding helper for struct opaque_auth
      SUNRPC: Convert svcauth_null_accept() to use xdr_stream
      SUNRPC: Convert svcauth_unix_accept() to use xdr_stream
      SUNRPC: Convert svcauth_tls_accept() to use xdr_stream
      SUNRPC: Move the server-side GSS upcall to a noinline function
      SUNRPC: Hoist common verifier decoding code into svcauth_gss_proc_ini=
t()
      SUNRPC: Remove gss_read_common_verf()
      SUNRPC: Remove gss_read_verf()
      SUNRPC: Convert server-side GSS upcall helpers to use xdr_stream
      SUNRPC: Replace read_u32_from_xdr_buf() with existing XDR helper
      SUNRPC: Rename automatic variables in unwrap_integ_data()
      SUNRPC: Convert unwrap_integ_data() to use xdr_stream
      SUNRPC: Rename automatic variables in unwrap_priv_data()
      SUNRPC: Convert unwrap_priv_data() to use xdr_stream
      SUNRPC: Convert gss_verify_header() to use xdr_stream
      SUNRPC: Clean up svcauth_gss_accept's NULL procedure check
      SUNRPC: Convert the svcauth_gss_accept() pre-amble to use xdr_stream
      SUNRPC: Hoist init_decode out of svc_authenticate()
      SUNRPC: Re-order construction of the first reply fields
      SUNRPC: Eliminate unneeded variable
      SUNRPC: Decode most of RPC header with xdr_stream
      SUNRPC: Remove svc_process_common's argv parameter
      SUNRPC: Hoist svcxdr_init_decode() into svc_process()
      SUNRPC: Clean up svcauth_gss_release()
      SUNRPC: Rename automatic variables in svcauth_gss_wrap_resp_integ()
      SUNRPC: Record gss_get_mic() errors in svcauth_gss_wrap_integ()
      SUNRPC: Replace checksum construction in svcauth_gss_wrap_integ()
      SUNRPC: Convert svcauth_gss_wrap_integ() to use xdr_stream()
      SUNRPC: Rename automatic variables in svcauth_gss_wrap_resp_priv()
      SUNRPC: Record gss_wrap() errors in svcauth_gss_wrap_priv()
      SUNRPC: Add @head and @tail variables in svcauth_gss_wrap_priv()
      SUNRPC: Convert svcauth_gss_wrap_priv() to use xdr_stream()
      SUNRPC: Check rq_auth_stat when preparing to wrap a response
      SUNRPC: Remove the rpc_stat variable in svc_process_common()
      SUNRPC: Add XDR encoding helper for opaque_auth
      SUNRPC: Push svcxdr_init_encode() into svc_process_common()
      SUNRPC: Move svcxdr_init_encode() into ->accept methods
      SUNRPC: Use xdr_stream to encode Reply verifier in svcauth_null_accep=
t()
      SUNRPC: Use xdr_stream to encode Reply verifier in svcauth_unix_accep=
t()
      SUNRPC: Use xdr_stream to encode Reply verifier in svcauth_tls_accept=
()
      SUNRPC: Convert unwrap data paths to use xdr_stream for replies
      SUNRPC: Use xdr_stream to encode replies in server-side GSS upcall he=
lpers
      SUNRPC: Use xdr_stream for encoding GSS reply verifiers
      SUNRPC: Hoist init_encode out of svc_authenticate()
      SUNRPC: Convert RPC Reply header encoding to use xdr_stream
      SUNRPC: Final clean-up of svc_process_common()
      SUNRPC: Remove no-longer-used helper functions
      SUNRPC: Refactor RPC server dispatch method
      SUNRPC: Set rq_accept_statp inside ->accept methods
      SUNRPC: Go back to using gsd->body_start
      SUNRPC: Use per-CPU counters to tally server RPC counts
      SUNRPC: Replace pool stats with per-CPU variables
      SUNRPC: Add header ifdefs to linux/sunrpc/gss_krb5.h
      SUNRPC: Remove .blocksize field from struct gss_krb5_enctype
      SUNRPC: Remove .conflen field from struct gss_krb5_enctype
      SUNRPC: Improve Kerberos confounder generation
      SUNRPC: Obscure Kerberos session key
      SUNRPC: Refactor set-up for aux_cipher
      SUNRPC: Obscure Kerberos encryption keys
      SUNRPC: Obscure Kerberos signing keys
      SUNRPC: Obscure Kerberos integrity keys
      SUNRPC: Refactor the GSS-API Per Message calls in the Kerberos mechan=
ism
      SUNRPC: Remove another switch on ctx->enctype
      SUNRPC: Add /proc/net/rpc/gss_krb5_enctypes file
      NFSD: Replace /proc/fs/nfsd/supported_krb5_enctypes with a symlink
      SUNRPC: Replace KRB5_SUPPORTED_ENCTYPES macro
      SUNRPC: Enable rpcsec_gss_krb5.ko to be built without CRYPTO_DES
      SUNRPC: Remove ->encrypt and ->decrypt methods from struct gss_krb5_e=
nctype
      SUNRPC: Rename .encrypt_v2 and .decrypt_v2 methods
      SUNRPC: Hoist KDF into struct gss_krb5_enctype
      SUNRPC: Clean up cipher set up for v1 encryption types
      SUNRPC: Parametrize the key length passed to context_v2_alloc_cipher(=
)
      SUNRPC: Add new subkey length fields
      SUNRPC: Refactor CBC with CTS into helpers
      SUNRPC: Add gk5e definitions for RFC 8009 encryption types
      SUNRPC: Add KDF-HMAC-SHA2
      SUNRPC: Add RFC 8009 encryption and decryption functions
      SUNRPC: Advertise support for RFC 8009 encryption types
      SUNRPC: Support the Camellia enctypes
      SUNRPC: Add KDF_FEEDBACK_CMAC
      SUNRPC: Advertise support for the Camellia encryption types
      SUNRPC: Move remaining internal definitions to gss_krb5_internal.h
      SUNRPC: Add KUnit tests for rpcsec_krb5.ko
      SUNRPC: Export get_gss_krb5_enctype()
      SUNRPC: Add KUnit tests RFC 3961 Key Derivation
      SUNRPC: Add Kunit tests for RFC 3962-defined encryption/decryption
      SUNRPC: Add KDF KUnit tests for the RFC 6803 encryption types
      SUNRPC: Add checksum KUnit tests for the RFC 6803 encryption types
      SUNRPC: Add encryption KUnit tests for the RFC 6803 encryption types
      SUNRPC: Add KDF-HMAC-SHA2 Kunit tests
      SUNRPC: Add RFC 8009 checksum KUnit tests
      SUNRPC: Add RFC 8009 encryption KUnit tests
      SUNRPC: Add encryption self-tests
      SUNRPC: Fix whitespace damage in svcauth_unix.c
      SUNRPC: Clean up the svc_xprt_flags() macro
      SUNRPC: Remove ->xpo_secure_port()
      SUNRPC: Fix occasional warning when destroying gss_krb5_enctypes
      NFSD: copy the whole verifier in nfsd_copy_write_verifier
      NFSD: Clean up nfsd_symlink()

Dai Ngo (3):
      NFSD: enhance inter-server copy cleanup
      NFSD: fix leaked reference count of nfsd4_ssc_umount_item
      NFSD: fix problems with cleanup on errors in nfsd4_copy

Jeff Layton (13):
      nfsd: allow nfsd_file_get to sanely handle a NULL pointer
      nfsd: fix potential race in nfs4_find_file
      nfsd: move reply cache initialization into nfsd startup
      nfsd: don't take nfsd4_copy ref for OP_OFFLOAD_STATUS
      nfsd: eliminate find_deleg_file_locked
      nfsd: add some kerneldoc comments for stateid preprocessing functions
      nfsd: eliminate __nfs4_get_fd
      nfsd: zero out pointers after putting nfsd_files on COPY setup error
      nfsd: clean up potential nfsd_file refcount leaks in COPY codepath
      nfsd: remove fs/nfsd/fault_inject.c
      nfsd: don't hand out delegation on setuid files being opened for writ=
e
      nfsd: fix courtesy client with deny mode handling in nfs4_upgrade_ope=
n
      nfsd: don't fsync nfsd_files on last close

Richard Weinberger (3):
      NFSD: Teach nfsd_mountpoint() auto mounts
      fs: namei: Allow follow_down() to uncover auto mounts
      NFS: nfs_encode_fh: Remove S_AUTOMOUNT check

 fs/lockd/svc.c                           |   21 ++-
 fs/namei.c                               |    6 +-
 fs/nfs/callback_xdr.c                    |   13 +-
 fs/nfs/export.c                          |    2 +-
 fs/nfsd/fault_inject.c                   |  142 ----------------
 fs/nfsd/filecache.c                      |   49 ++----
 fs/nfsd/nfs2acl.c                        |    5 +-
 fs/nfsd/nfs3acl.c                        |    5 +-
 fs/nfsd/nfs3proc.c                       |    5 +-
 fs/nfsd/nfs4layouts.c                    |    4 +-
 fs/nfsd/nfs4proc.c                       |  206 +++++++++++------------
 fs/nfsd/nfs4state.c                      |  130 ++++++++------
 fs/nfsd/nfscache.c                       |    4 +-
 fs/nfsd/nfsctl.c                         |   77 ++++++---
 fs/nfsd/nfsd.h                           |    2 +-
 fs/nfsd/nfsproc.c                        |    6 +-
 fs/nfsd/nfssvc.c                         |   23 +--
 fs/nfsd/state.h                          |    2 -
 fs/nfsd/trace.h                          |   31 ----
 fs/nfsd/vfs.c                            |    8 +-
 fs/nfsd/xdr4.h                           |    2 +-
 include/linux/lockd/lockd.h              |    4 +-
 include/linux/namei.h                    |    2 +-
 include/linux/nfs_ssc.h                  |    2 +-
 include/linux/sunrpc/gss_krb5.h          |  196 +++-------------------
 include/linux/sunrpc/gss_krb5_enctypes.h |   41 -----
 include/linux/sunrpc/msg_prot.h          |    5 +
 include/linux/sunrpc/svc.h               |  133 ++++++---------
 include/linux/sunrpc/svc_xprt.h          |    1 -
 include/linux/sunrpc/xdr.h               |   28 +++-
 include/trace/events/rpcgss.h            |   22 +++
 include/trace/events/sunrpc.h            |   28 ++--
 net/sunrpc/.kunitconfig                  |   30 ++++
 net/sunrpc/Kconfig                       |  102 +++++++++--
 net/sunrpc/auth_gss/Makefile             |    2 +
 net/sunrpc/auth_gss/auth_gss.c           |   17 ++
 net/sunrpc/auth_gss/gss_krb5_crypto.c    |  662 ++++++++++++++++++++++++++=
++++++++++++++++++++++++++++------------------
 net/sunrpc/auth_gss/gss_krb5_internal.h  |  232 +++++++++++++++++++++++++
 net/sunrpc/auth_gss/gss_krb5_keys.c      |  418 ++++++++++++++++++++++++++=
+++++++++++++------
 net/sunrpc/auth_gss/gss_krb5_mech.c      |  730 ++++++++++++++++++++++++++=
+++++++++++++++++++++++++++--------------------------
 net/sunrpc/auth_gss/gss_krb5_seal.c      |  122 ++++++--------
 net/sunrpc/auth_gss/gss_krb5_seqnum.c    |    2 +
 net/sunrpc/auth_gss/gss_krb5_test.c      | 2040 ++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++++++++++++++++++++++++++++++
 net/sunrpc/auth_gss/gss_krb5_unseal.c    |   63 +++----
 net/sunrpc/auth_gss/gss_krb5_wrap.c      |  124 +++-----------
 net/sunrpc/auth_gss/svcauth_gss.c        | 1099 ++++++++++++++++++++++++++=
++++++++++++++++++++++++++++++++++++++-------------------------------------=
-----------------
 net/sunrpc/netns.h                       |    1 +
 net/sunrpc/stats.c                       |   11 +-
 net/sunrpc/svc.c                         |  158 ++++++++---------
 net/sunrpc/svc_xprt.c                    |   20 +--
 net/sunrpc/svcauth.c                     |   13 +-
 net/sunrpc/svcauth_unix.c                |  178 ++++++++++++++------
 net/sunrpc/svcsock.c                     |    4 +-
 net/sunrpc/xdr.c                         |   79 ++++++++-
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c  |    1 +
 net/sunrpc/xprtrdma/svc_rdma_transport.c |    7 -
 56 files changed, 5234 insertions(+), 2086 deletions(-)
 delete mode 100644 fs/nfsd/fault_inject.c
 delete mode 100644 include/linux/sunrpc/gss_krb5_enctypes.h
 create mode 100644 net/sunrpc/.kunitconfig
 create mode 100644 net/sunrpc/auth_gss/gss_krb5_internal.h
 create mode 100644 net/sunrpc/auth_gss/gss_krb5_test.c

--
Chuck Lever



