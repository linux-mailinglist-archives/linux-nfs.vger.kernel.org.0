Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 419C33D415B
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jul 2021 22:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbhGWTc2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 23 Jul 2021 15:32:28 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:10602 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231268AbhGWTc1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 23 Jul 2021 15:32:27 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16NKB6ZE015096;
        Fri, 23 Jul 2021 20:12:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=lEfQBLoOWhsxZH3g5h3kWyj0UZMwp8O8HfvvQ87k8+Y=;
 b=R7Kikd3APUfiigWF91Qp8rMyLSohPI6iK01F0y4Xw0GXhBGATxzaWNzEBPHux5bfmoNg
 ZEsK9pjbTJGH4YZwNOlDu5ucAu/pWFDlFPJPDBpBml4rEKAkyVqR53Tol3LhzINwGle4
 T8CDtt0B3SBguPwcIacTIRjQrIqrbSV3nvDnkTwjDJSiSW27r15Ih7NWDUxH9mfGg97g
 6EQHdH8LaXvVshQCvn3qQqCVj720p16CQwDEm2vM5FZlQifJkDh98aHhGHb4XXKRBYkp
 85oRvXBUPRhia0CEn+AOgZO1oA4Lr8TMfqo20cwhy9u+CwJ0qjd0I7z1BykUHcajbyBH xw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=lEfQBLoOWhsxZH3g5h3kWyj0UZMwp8O8HfvvQ87k8+Y=;
 b=EyfUYof+uTnpFk+sCVVekHVamv7gIsh5U6BX6KL5jdHzoZlUOnhbpkNXGuECzBi8im2C
 X8uWzGrO1nklhNRAVC65qbUsNWaHjJREgeB7Ven8631d3irRbFW2TXyvfZv1DnmkWVJ2
 APyzwZ3LMSerD7gMzdP9stNZMlj/By1ilnt0ghG6ahUrYNNKB4ZlXCzUXrX3Pj+b9IOW
 x06nMKftyLcpY6NgHsFjofN2u1rB52abLZuYSuJWOL30gP9sHL/L3jB0G4Xec8bE6uAs
 qrzMnMMaaYHYAAeVntqiTtflzuw/At0ks3fc7/NjLXqGd3azbO30B68HwJwDbdX9el4b 3g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a043s81rx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Jul 2021 20:12:57 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16NKBJIe135442;
        Fri, 23 Jul 2021 20:12:57 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by aserp3020.oracle.com with ESMTP id 39uq1dsqn1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Jul 2021 20:12:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KhxPDx+THaMn59fRYmOVmlvYY8ad5iimQsZt1NiWG8xBhdKhwe7GzDsULQKgankMRK71ZCWlM6T/BZzeiTZRzYL7VIuvjNsMNd7uOFq6FVgFJb4Qv0nzTo2hkeUSHkV8fUd4AGKfsEwAZucJS2V1s/msucEJkH7gy+ildkOLlZ4s75WnX3w/VghSgJpy+PfVRPlsBTQtwEDnIGjDGigJ1t/GL5A9NX8lM5rpJOH4Pap1dRKZp94O8LTuayKFIW36fvVXfdbE0ZuhwQxZFeWK13uQr2qDJ1bdenx/JejqrbYwhsSmt0ECC/la1unX9Wevm7DKzWEYLqnRjDRfTUMtbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lEfQBLoOWhsxZH3g5h3kWyj0UZMwp8O8HfvvQ87k8+Y=;
 b=ULTWtGJ2r8RP8wAsZUBI55IkfnXS6HyubRB93Z6xvmAccvmGfV+SblDIEmgLUPeqVGmbY3//alGRW27YT/A/4+srwAydtDgSOL0/PkM/P0iMexfrdrM1XPA9R0EPbnjbG2HtDP8vh0VXQLhpOQLfnkBb2P23ufAU0yJm1tmce2LsfE/h37cDEZadK+pzRkNuE2gHIWUHb8aPkgQPlmXL1Kdoen7HfYXrP34qqQXgbfn6nkmXONmI9LuOcHNViZ+HaH79HkCSZa8TmZhf/eTWwfzrZeQjy5v99FvUeOW8oroqLh5WuWS23WG4XcAyjUpZt6X5KSrqmmDuYCCjeH9j6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lEfQBLoOWhsxZH3g5h3kWyj0UZMwp8O8HfvvQ87k8+Y=;
 b=TZVoHx2AnN5BljBfFHViJlCxD59kI1tHOe1qzrTqzKbwyWacrvyMp/8t4/FCfCWCX7SJkdgChyu2aIt6fMPZ3Pq6oi1tRpYMe6RH1kKekSE4fPHT/RRYq3npl33+IJ5+ZmJCzcv9NIuYq3HAVn3WXXTTKKCQuL5IYq7X1M8snp0=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3047.namprd10.prod.outlook.com (2603:10b6:a03:83::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.29; Fri, 23 Jul
 2021 20:12:55 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::9dee:998a:9134:5fcb]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::9dee:998a:9134:5fcb%3]) with mapi id 15.20.4352.029; Fri, 23 Jul 2021
 20:12:55 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: recent intermittent fsx-related failures
Thread-Topic: recent intermittent fsx-related failures
Thread-Index: AQHXf/8fcA3+DfY3OUmOk0QnMZuIQw==
Date:   Fri, 23 Jul 2021 20:12:55 +0000
Message-ID: <67E1CF9F-61C5-4BB9-97FE-61B598EFC382@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: hammerspace.com; dkim=none (message not signed)
 header.d=none;hammerspace.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e84a13b-fa4b-4632-5382-08d94e164201
x-ms-traffictypediagnostic: BYAPR10MB3047:
x-microsoft-antispam-prvs: <BYAPR10MB304787AEECA2A0B7BBE1B77893E59@BYAPR10MB3047.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:361;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3l1CPwIQp0/sEiBf4CqAOEvDBpAVJ16ddIVfA7UbeCvW6P6X5Is1sLLpZ1oux4aQxHziTsCjpWE4SPLqMc/IxrMP+nKI5Z96S+HVr4+R/HhAY4jTk3vPjG88W/M9UANcKzmxjKk5f6CbLwYCEe2zLrJIkDdT1dXoM4YLEjEmCShcCLGE5EDE3jpBurw1c0EGyFacy1KgZJaQg4ZlO1/xGf+8mbvGQ9UR17qA7LTjq7Xom1sqTh2BQNaqciErBif+/qVxhxo1eDSWATUHdOjNoaKPzPwrvBytG7leH/jMPLdFjeaTmV19d+oemk9xXzhDKLe/en8Jyi1smQ0BiRsBNdUvQ7aWVYr/ZJO9Y874YOOnyUpSXyi3qQwIrtgPUKVktCA+NGSWH73c0qBAifN64+80Mc2dhlBEJ4tKZMwKgp6GV/H3VE6MIfm0nY2WDBVjLwLMlvRl1I+n9ME74r2LWPlXQVWszqcdteOhicpP4WevVtDKMSxSOVPObcaabsH7idGlOEOO7SuEUpMGrAogFJR8/vZc2lAF6c3qNqVuuAa+UZmhOxBxC5omxuaiUZoUes9qc/sAmOjNH4tVTEjtQjilZ7DJ9Ow2OckzALiw2C5N8zJ1e1lb8klnxlLM5pFG4SfDxOc1c1gIvVY8FK2sNn2NXKMHiWa6Ye/2bCaKt3Ltp/y9NIIvGbIdq+PYY+gz1DBpPr3ACU3QXNetL9m64s8a4fvnsCVCvNCTvh98gRQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(396003)(376002)(136003)(39860400002)(316002)(5660300002)(6512007)(3480700007)(36756003)(4326008)(478600001)(71200400001)(33656002)(26005)(186003)(4744005)(6506007)(83380400001)(2906002)(2616005)(8676002)(86362001)(38100700002)(66946007)(6916009)(64756008)(91956017)(6486002)(76116006)(66476007)(8936002)(122000001)(66556008)(66446008)(45980500001)(38070700004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Mz6i54RYjR9Z7eHXg6pjgBCsAzJ5hSjpWDg2MePxEhDvTcDJPECpODLS4LiH?=
 =?us-ascii?Q?azPeSr9IXJBlQcVy0VoWvTHu+njhJuVzUKfer+/3KErOsgWNH9aVupLc2VzT?=
 =?us-ascii?Q?y4/bHEijiodQjiRZyMA1fhYOqMNGX27zHe48Nm0LvRrOPBXuRDn2zKwA7Eh7?=
 =?us-ascii?Q?YYVdNsxsvvE43W7ermrZw2GwQE7Bl7Pz0mnqqOajLkmP/OiH0rHU8/rIgox/?=
 =?us-ascii?Q?rDb7O945PYC8w8EKYfJmyJMgRFjWT/Lc6ejz73LcEtVvIVeJwhA0/T/BIEK/?=
 =?us-ascii?Q?WMX28c+xB8RnjjFHN5efKqdWiS6R/CG0ws7FIkCKET8EihQJ1QGPiDhngK/8?=
 =?us-ascii?Q?/KGZbbPjq+GLlwWYXjlOaHJ5AdhAmwoWcwPHd04zOt0Jur5QQPnU9Un0bxSr?=
 =?us-ascii?Q?isHjiPsCShMxG5KFyjaQ438xBJCL+YJDI3llTeg2TpeSkZAXI807R4LQON0a?=
 =?us-ascii?Q?wD4OHO8kWZcua61d6RtvcItF6SCtSfSRC4z8pCaK3qWnzs5wA8LXK1vAQakv?=
 =?us-ascii?Q?S2RQ9VErRH1swZcbllUVfgQe7hCvgWjqU4eZZ1cDN4Jt6N10YdVBzrYzc7i9?=
 =?us-ascii?Q?aTh2xkk90XyfsbZzqldXqq8rUJfI1VJU9+r5wtJewjLQLdNzQHffiHRzPeGq?=
 =?us-ascii?Q?DH4N0nVCPwG2ft8dCHqhK+eeDFq2c1f76ztSTRpeIol0jE82r2+fQVNhf9Ic?=
 =?us-ascii?Q?VaBMywoIj7NJ0UgcvRqQGBuzk4sxh51Al3V3P7XFhKulPO0NYhFLuHDs9+5H?=
 =?us-ascii?Q?mdiZQsY5uT6cXw2oOWm3b0A91kH6K5e7mBnwmUsLbpkeA4H9rQ+QqLU/fz70?=
 =?us-ascii?Q?FRLVlZO0wrw3nzy2T2c9c9FS7pa1jGm3T/foJRuF7V7VHRbRFEmYHOJBrCTq?=
 =?us-ascii?Q?CqG36mbfL4/33CvyP//7YeGd1+v0mehQyga+DyzB6fymjmJexX4HCtkkONRK?=
 =?us-ascii?Q?N1fC/MPObMOapS8NfjovJCLOlz/Eek/qOoS5WXoGfXi34/OdkulujFQADN2c?=
 =?us-ascii?Q?riz9i+/Yf4Uqmpr1tSrynjssAAW68MwZBiJ8q1tfaww8iaCsy+mZtpZi8eGr?=
 =?us-ascii?Q?F//bzXExKzsQDYzhdCFIgePBa/lOMQPPSfXmkrDtw2D3P1YNykpA+bcdReiq?=
 =?us-ascii?Q?kmv0AUE0zObHM1UBK3wflnfv+Zv4JuzMvLmYOnora6lVY3tLrPYDFRsOffqg?=
 =?us-ascii?Q?HLsqYFGT2p/kERdjflPm8uACuZp/bk3LA+g3EBbKSaH7SGyNOgXmfMyJPdef?=
 =?us-ascii?Q?YBQEGkShAC4RbkwCEQ3uE3NYvjBQM3UrNBpQDzhOX7YjYy6jQA0g6iMXLmUx?=
 =?us-ascii?Q?e1jT44GNdFZbcF5Sw8wOp+VO?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E93FAB8C79DA1448BD4BFC0A03383DC2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e84a13b-fa4b-4632-5382-08d94e164201
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2021 20:12:55.1742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NX2eZCwPZm/OzsRevKXNoc95dPmZO10g9roHakzawNioBmXVhe9CeBftYQ+/3s+Y8UUPk3qzMHhe0mMxc2vNfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3047
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10054 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107230122
X-Proofpoint-GUID: ndlxp6aoDgnF9QPPpK291epn4NmWhElx
X-Proofpoint-ORIG-GUID: ndlxp6aoDgnF9QPPpK291epn4NmWhElx
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi-

I noticed recently that generic/075, generic/112, and generic/127 were
failing intermittently on NFSv3 mounts. All three of these tests are
based on fsx.

"git bisect" landed on this commit:

7b24dacf0840 ("NFS: Another inode revalidation improvement")

After reverting 7b24dacf0840 on v5.14-rc1, I can no longer reproduce
the test failures.


--
Chuck Lever



