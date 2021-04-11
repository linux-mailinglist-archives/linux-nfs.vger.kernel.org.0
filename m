Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5352B35B62F
	for <lists+linux-nfs@lfdr.de>; Sun, 11 Apr 2021 18:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235849AbhDKQr1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 11 Apr 2021 12:47:27 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:45442 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235779AbhDKQr0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 11 Apr 2021 12:47:26 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13BGg7fd110295;
        Sun, 11 Apr 2021 16:46:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=ZmSpE5xu35W6QkGTVv6oCvRqNSC5S/LPNcerAMo2c9Q=;
 b=V2fvQ6YnlH7YpfEJS/ciNnZtGX4XaCAEa3msjlh6ySH1IzvFpy6JEYXiML5n+9pvjiYr
 +1UgWnWBMoAKdgUYb/18vwYCVCBsKkNcB8EV/yG9LfzYUh4q9G0jzIWVQgf0qntn3rVZ
 kybThYmgYR6ltZo23pANrraRKdkLx7o1rB3VYyLrZleARKbTFqc5oL4wh5obDIeWDwAq
 9CYrrWeMI8dggeQ84g5jxtXpUkEZXQ/v/jnaAngRW+9aLnKKyvMM7mPSVECOlcAPNvWZ
 wGge4+Jkk9DxDU54YCNP3yx4QtCOJcnaBsjfSbCRTOS2Me4SibNM2Hd7aKgw3tA0nN4L qQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 37u3er9ted-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 11 Apr 2021 16:46:57 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13BGjMQi148148;
        Sun, 11 Apr 2021 16:46:57 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by userp3020.oracle.com with ESMTP id 37unsq1es7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 11 Apr 2021 16:46:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ETlX5w2wd5MRtKeefD4Zoo/ydeqNpAl7LkrVzF2V/GPAzYCH0Gr89vNLdhGEYtoYt3kVQj97UWsiWrtEc3ohtBL9Zf+1NDSV47MtTXJMUXKmj4GXCmg3itFZJPAWo2iLYsaJmAeOdelQFPDboBtHEW7qbDHURiD1hQVUUL0zV1rwf1+e+dcMZJs+BYp9b7CV46Y5eWxA+Q9up4Jxa6nDdgFlkt4czfbApYJ2oxC10BbL15kal9egSajvGEMaWaB1LxRAxS2WfB6ebcVYFjFvbZmg+Q/as98yit/ILBLwZk4G799JcVuYvGfsDfIkLk3DCo5vw2LwFIKXJ3pjJeCkzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZmSpE5xu35W6QkGTVv6oCvRqNSC5S/LPNcerAMo2c9Q=;
 b=PuRDfVYNRyymRSAWexgOVTF6u2cmozEHF1os6/Q10oPxTEYGqcZ2PJHQvT1Pr9qPt8zHQzzmL0oS2CwUt8wDeoCvAlvQhHSjsp9FpNxJmtX82vk1+y1hTjUZVzQPYKExLzf1PpKFNjxT+ULXx0KKHUWfC1gcYx15lRjS3rwMyssrqc0WQxfLDCAnf+ajSlKm73H6d/xgLxJJOL6xgUrmRTc9u/uBPhrb2i9t3I9+El3A1C4kzl6DMLghlFsc+xntVncsYJxkrhR5JuU8zIUqzkCifFglugMCyzm1I039We0a9YN2+H68GMsDiVnRUgWgytOaHrSx8n3bvlbq4NimWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZmSpE5xu35W6QkGTVv6oCvRqNSC5S/LPNcerAMo2c9Q=;
 b=wD/UuC1/SGLErkh+BoiIFPyJQCTL6E4gZsVW1d5RmspJ/DoFAOa4ikVYQe1pHx83Z1Hg53KXwNxX1URURHfUr1+d+RJ+soU3pefuHAZc6HJS61SfAXrKKtG6iERR1T4ZDvVualCvbaF0e2SxI0xFN0gOBop716nz3kVovT7Ot8I=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4525.namprd10.prod.outlook.com (2603:10b6:a03:2db::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Sun, 11 Apr
 2021 16:46:55 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9%4]) with mapi id 15.20.4020.022; Sun, 11 Apr 2021
 16:46:55 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Bruce Fields <bfields@fieldses.org>
Subject: Re: [PATCH v3 0/2] NFSD: delay unmount source's export after
 inter-server copy completed.
Thread-Topic: [PATCH v3 0/2] NFSD: delay unmount source's export after
 inter-server copy completed.
Thread-Index: AQHXLWs+IUqPLQz5x0aAPxNFKIe5u6qvibcA
Date:   Sun, 11 Apr 2021 16:46:55 +0000
Message-ID: <5E7177EB-DE0D-434C-89DF-5BC090FBE642@oracle.com>
References: <20210409180519.25405-1-dai.ngo@oracle.com>
In-Reply-To: <20210409180519.25405-1-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 217c1aae-988d-49ca-d6f8-08d8fd096a40
x-ms-traffictypediagnostic: SJ0PR10MB4525:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR10MB4525796D065934A47F6F90B093719@SJ0PR10MB4525.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gnqW/Rj3uGxS0JecyoPDAMTjBUwVxGsIrVfoNEiHpmd6E0Izf9+bQNgndGrMNTNsPYcZ4e11QSCDxFEo870C6vooqX6tY7FsjjFqxbCUJGlpmV+RGXlCC/swvqumN/D4ZWVrG/M7BFv+tcLcWi6yJcI516UdC3JBbD4+8xHA5Z4r95micdpNxiYgYPLBSR6vA03ZUKSrsLRZ79uxkmwj6Xm1Jw4Ik3dOqv31vvoT83c+LcVkVfPbVRmK7Xgpw06rWI6O02q174MaLdixJGzFKLkRIUITcvf12m+xZWI27rSCPKp5SVxaq+R3GEPwSHYG4uBDXUIGLEEmzvc03jf2N20ySxzY3FCIpyoGgUdisDiXgrxf55zVzu12NUZ1VLMICyuseNqhZn0SaYDFbueJ6ZcQG1JnExsaw/XC1DH6Wx5TzZcIyRRSGMAdRiMEjx5YwjenUubCFoA0SoBHIKD0UGPi9m24PYn/LJDQqjBi4S91fAP9Qy6CnjSTLU90YmZizCwwh/FKYj5hDcYLPFl6HD1Td7P160GOh+RN5n/zAHWHq96o0o3z8IMMGwf6Uj6lFaXUbpE/wAi98ZlAr7RXdHHxgYZyVlhIZtau39HOfIVwxWUH6Ul08QrVDIut4LetnltCmS/t0PvwI09dPWxZAgb/r+1885QgCVsuylfyFak=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(396003)(39860400002)(346002)(376002)(83380400001)(64756008)(91956017)(66446008)(66556008)(76116006)(66946007)(66476007)(478600001)(5660300002)(2906002)(71200400001)(38100700002)(36756003)(33656002)(2616005)(316002)(186003)(8936002)(26005)(54906003)(8676002)(6486002)(53546011)(110136005)(4326008)(6506007)(86362001)(6512007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?NXryvWHsV8gujsBxQiNGMVCJ3+hhXKEDskbn9hjzIZa78pEv+1C/knhdak2A?=
 =?us-ascii?Q?neVZxiXZcbmaWIh5hRqfZxc5151fN995FWvg349e6SBjHP2nHA4cHhhWlQGM?=
 =?us-ascii?Q?SkGc3Yzq/jaLBoOZ+YKIC3dc1pt+djE+agv4z9hd/Gp8nyVrOM6/6Noi70tk?=
 =?us-ascii?Q?xvs7FriJdqvhtZtyvJw6lyZ4cz0y5sYK2UnnTSTT8UfStg17Txmz4clMy8CD?=
 =?us-ascii?Q?BhvMIRWHM0g0dVmk6GdfmWhBjeckW57lnTvsHEds6QQ51o2KXbUPuzcKb7gA?=
 =?us-ascii?Q?vPiNEZmd1QBDlTVrhOTDHewGZOSn9kS7/s66wHs3+eiLaA2QpSyngDzTc4MG?=
 =?us-ascii?Q?loKx0fvkQ1wNSaPsm2H24C5EyYelgSg8aq/LCkAOYotppG3Sa3sPzhMyV2mp?=
 =?us-ascii?Q?Mkztp7eXU+aMuPFqK28dRvrERuhmguEYuZlCMC495AkO39A+eRLnclUGZ7XI?=
 =?us-ascii?Q?OAQjZbokKjuGtR6ORJ4ZKI3tCaeWi3D+H01bSbQKeDCONR6YIqS39oTx5EhO?=
 =?us-ascii?Q?GEFmdeLiokCSLMxuFSKRvnxrfreVqd0cKd+SvP+sRgXuVV5gB8ng0mxMiuYR?=
 =?us-ascii?Q?t5arFsnavhOwyRf66pfynlFBgx0OYPw1pK8m2dmC1BXlYbTtOXt9o7U+8xdC?=
 =?us-ascii?Q?HeQLqXgLjL5E2Mik/aXkqkwaOup9LkXkdVpdLO8mXZQWmdPizm5J5YcKRkCx?=
 =?us-ascii?Q?ca2QDOB+1MJ0PmhykkInrT/9IWLmCjXN+wOOtYzLGzorGljBuYhdg93Ffl8j?=
 =?us-ascii?Q?cfVoDH+RO6iL08IMSP6kVoebwwLRQNN3BG/zWoREzhAKv/md7lGJsG6taB7P?=
 =?us-ascii?Q?cB3+5PFgQUC0vC2l4HotQCPGwCgFbJAZhwY+puICMdW25WaJDKEp8exhL3H2?=
 =?us-ascii?Q?2OWafyaCue7mhuaQNsYEANGPDotW5WgdMNz53TsnrfndzbljZlk7SQiLebEf?=
 =?us-ascii?Q?KjGqntYAhc4df390EcF/tzpe0xIDgOwk99IrRAjETg2EClabNxJdAoPcDs12?=
 =?us-ascii?Q?FR2/oJYrsp0dMZbCf23htmMGtIRpfOwKSL1fpHt5jyspF1umDu7NdEJ983S9?=
 =?us-ascii?Q?8IFHx20pxqGo+HFW97QlzXPptuE6WNr1eEjV+tfHNBR6IyA08vqIGGPYQFo2?=
 =?us-ascii?Q?WU4noV8oTnnB7WvIvSSGCRs8mm2ba+7G0cL/pUyhP50yJXStC8voqnhfyzIa?=
 =?us-ascii?Q?SnxMl0PdtXqyMMSc793CDSCGip6GV1VqPwYqXG1gzPUZ1OUd3GDAHAHsP7Wg?=
 =?us-ascii?Q?ybHPXMUmLhvrt0GCFMflKtNhUUXHbTUD0I5C5Czq0bKQPv0LUBX9a2taj+Ui?=
 =?us-ascii?Q?w+8QbdADCFk6ChQhVjb6Lusx?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <15C91E0D382A514997209512AED0307D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 217c1aae-988d-49ca-d6f8-08d8fd096a40
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2021 16:46:55.1315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6FeEkNMwXsYLB4xxIC3VgiNBtYALZC+93ukIC0XO5W3Rk274jX+gF/TRyfuZc9OspWvQPjMYt94iLIUvob1CAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4525
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9951 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104110131
X-Proofpoint-ORIG-GUID: Kqbhb9PJV7w-isII7yG6Ezuzr_ZUrRJX
X-Proofpoint-GUID: Kqbhb9PJV7w-isII7yG6Ezuzr_ZUrRJX
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9951 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 clxscore=1015
 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104110130
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Apr 9, 2021, at 2:05 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> Hi Olga,
>=20
> Currently the source's export is mounted and unmounted on every
> inter-server copy operation. This causes unnecessary overhead
> for each copy.
>=20
> This patch series is an enhancement to allow the export to remain
> mounted for a configurable period (default to 15 minutes). If the=20
> export is not being used for the configured time it will be unmounted
> by a delayed task. If it's used again then its expiration time is
> extended for another period.
>=20
> Since mount and unmount are no longer done on each copy request,
> this overhead is no longer used to decide whether the copy should
> be done with inter-server copy or generic copy. The threshold is
> now a module configuration parameter, default to 16MB.
>=20
> -Dai
>=20
> v2: fix compiler warning of missing prototype.
> v3: remove the used of semaphore.
>    eliminated all RPC calls for subsequence mount by allowing
>       all exports from one server to share one vfsmount.
>    make inter-server threshold a module configuration parameter.

This series is close, but it doesn't seem 100% ready yet. Let's
defer it for the next merge window to give a little more time for
review, testing, and discussion.


--
Chuck Lever



