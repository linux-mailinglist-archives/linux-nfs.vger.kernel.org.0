Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD895E6D1A
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Sep 2022 22:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiIVUgh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 22 Sep 2022 16:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbiIVUgg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 22 Sep 2022 16:36:36 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25B0106A2F
        for <linux-nfs@vger.kernel.org>; Thu, 22 Sep 2022 13:36:35 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28MKYcg4016753;
        Thu, 22 Sep 2022 20:36:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=5qZHmWhwDxPZXsS97ENhFfBBJHerOXl/4Y4y1tBpt+k=;
 b=B9fT3LrjzwzpBGkPTgKaZw9pjr1rh0mUbdUBviqSungoLSyOJ3AldE/zZSUVrRNveK9B
 OkOACY1/6TX2p8EYD6u33DZOKoAayk549Kg97ahEgcdlFUO4EmLgGRL99pMyRCjrL94G
 olOqG0kZ3hOBaK+O19oIfpjBJDQOThJIzw9EcwJ1cSBlUd5sIDLQ9hl/tGULYa8zCWNr
 yCKFQW15AruTYJvuC07jPoQUQ4BAkfh7fp9PWQar0gfjm1VqLzG1l5ppVJ7ZzJduUynH
 sF2O3ZLaIDsoDwa1D1RnvdMXD27+DH8BJvo0bK5p2L7ctiZuVkHFSaN1hv1ZVH3RZW39 ig== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn68rpqp1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Sep 2022 20:36:32 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28MIFZ6f028927;
        Thu, 22 Sep 2022 20:36:30 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2042.outbound.protection.outlook.com [104.47.57.42])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jp3d51mbv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Sep 2022 20:36:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VCApcBa2G1cULRlNNaQM1AHqiAnU7Nty39bGfHqcOXfnb5QcF5VN2aB5TiNRlaH97feIVQPW+ifaOrSSXtVEi+0pQqf5ikGSiH/+jepfFC/cAZKX5760xu9H2gXe53amhbd50U1QyoNBrMOrlgbTUPp3M1DM4mL7qGO3fG9bDmt5vESWHKu2EPW4fEDn+dS3GfJxKdKgxYqBP3lHZdTZ+/RNmt/qpx+c+7o618HvvAi6zqduUVQy7unK+PtDp87UJVCy1JXvvcg6muN0dCRyxFJcgMUEOXTMO8wFyiSe3O/KCInD98wEy2FPTs7RDF8ep9yNYO47Fe8WtSAIcwPxSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5qZHmWhwDxPZXsS97ENhFfBBJHerOXl/4Y4y1tBpt+k=;
 b=AQfIOmTEecPXRrx1kksEyir5IEwIDwRmvlVkjZkLBuoxvSZCkIl09BzWs47CcX+oWFdc9tmTDolTZ35bZIBfydwKditIIMwijG//e750RiNRfDsx6vwGd8c/jRKXMSWcDuEZYRq0nb5k3ZBlQqS8agorWH8jhtK4vEB5G/KfQfW9EKqVuo5XM4kpkep95fJoYCEEqIpP3uAv6WixCiaYf8KJwc+FFMyamiXr/s1PtvMJCp5F7verdCr7Pfaqm4K3xApzzgLJKnm6vij7U8M52B1L47asCDYlKZp0d2IlJx5p6vs+DuKlQGXcZB94j9KDZtPBaS6odfWUXop+W6lMOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5qZHmWhwDxPZXsS97ENhFfBBJHerOXl/4Y4y1tBpt+k=;
 b=AVl13/a4D0qJh6z2ByrO+vSyuUZWGqSdxzOjTMd7n81xqdY3IE8omchTYgFl8S6JhLQgGEIatkUa7jPnSoFRKiwBm8VhGyg17TdOMIaOYp3NRF6b6mBOIQY0auUsiFSSZUioEGyIomO/CsA7lRuW5/qhp8cXsPyNughNQcn1lm4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH2PR10MB4374.namprd10.prod.outlook.com (2603:10b6:610:af::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17; Thu, 22 Sep
 2022 20:36:28 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa%5]) with mapi id 15.20.5654.019; Thu, 22 Sep 2022
 20:36:28 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
CC:     Jeff Layton <jlayton@kernel.org>
Subject: NFSD XDR tracepoints rebased on v5.19
Thread-Topic: NFSD XDR tracepoints rebased on v5.19
Thread-Index: AQHYzsL9gk5KmaCKs0GkRAHOL4s0Zg==
Date:   Thu, 22 Sep 2022 20:36:28 +0000
Message-ID: <93CC3B5C-32D6-475E-B034-4F1AC0F8E279@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH2PR10MB4374:EE_
x-ms-office365-filtering-correlation-id: bd30f0fd-fbf5-4383-3e9d-08da9cda2054
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I1R7oT6TtdF+MSIxWIRHdYbNsO25ty17XooiXaKN1LmIEc5Ov7BHWjT/z+SwPwIVlAD1FkxAIN0QEhl7N/iPtdyfY/WzfkfXElb/HGnUkL2uHO0lys0HuB7hRrLXh+RGmwXNx4inx2CN+TMuFPETxYvMpNzRfIO3dpFGY50Y2VpgVS3cMyZSQbEHtdVkZlzzrKy00eO5PBY+EuQJmkK+iMAFLaIv12rixiM8Z5+6u285Pj8Nl0dRoxkkt6s3ZOtiV+RKSFiwJc7EyN4TzsrBILuV5Fd1gkE68dfj8RpRQeC/1uEO/jvwu4Y3rbHZVN0dZPhaH8OKWFDli/0k77zfSckwL8PxXeh5M92VJWeNBMPY7VZBaM/BwHkqTgww/PwcBb6qHXWm/FsjTfvSddHoi+GNpuLUfGtexppMAxgHThkEv6EsBTiE6HN1sVRwyT/GKLJ8RbfxNFus/nmr6NiMUm/AMDsuoUBpp5r7W/oAxs14x88dmStbYOmH06rOzGYigEIoXZ92Co5RapnagL8vIM//onJfCHA0EpGbifWvP09zq6+lSI07GEd3W0DJSvdUfbLc86CRzszSP/pjyjTlTw15cjsnkahOhWjxOyzx5sG/LjgHYXkkjNvCUscYOBLJvYIbSKPh5l821ln7tBdC475ItzbcLfHN4l4iUpZv7Kn7TVmcnY9zZrAJhb5r6nkZf6lnDlb+jgiWKkWMmTpurA6rS3KTFXmO5hB0cUEyvgebexy3tEtq87d7kIIUYMWG7n/nTOR+ZmGFsKefTuwhV8/4NjayoY1jHFYIxdK242ylUbgRVGzsRVbe6TlmaNVu9SZ9XZ4iTb3rXyPGAL4/oQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(136003)(396003)(346002)(39860400002)(451199015)(86362001)(66446008)(966005)(478600001)(33656002)(76116006)(6506007)(316002)(71200400001)(6486002)(91956017)(66476007)(26005)(66556008)(8676002)(4326008)(66946007)(64756008)(6512007)(41300700001)(38100700002)(122000001)(36756003)(38070700005)(2616005)(4744005)(2906002)(5660300002)(186003)(6916009)(8936002)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xPiAasQESpO9QuiS77OSByvhljEWcHKwxcDwH7/cCNwGf2GB0syFp2LiU18l?=
 =?us-ascii?Q?CmYVKWe9d8ZIqHoguDmhgdxETMun6xwVUWJM+UJr8jJ5JNyTTrSiengZnmVV?=
 =?us-ascii?Q?SVXUNrEV2fjsjsSxzjwZlYVuYL3xyvdkpDJOBPZEzyejvg80yAG+Zj7eKcUW?=
 =?us-ascii?Q?21S+3rFzjSJC1NlKQf1ctlfe+5LwcHouB8qO8dFoANYlBHl+HLUnfQypmFac?=
 =?us-ascii?Q?XcJyuG+4kFUwWZt7LxeGqQhPnOAMiMbRNxJPO1isNXJ+Z+suBTH+iuTeF+zX?=
 =?us-ascii?Q?r3M32WQpKtyMRgF7pjxJleWmJrysODIl2RmTo8oY4dczguRfL8CSc2WJhLvs?=
 =?us-ascii?Q?TYkE0faDCv24IEQ9PTe105bPPnj968Vedbg8eBH05PYOVRkfyUbjEq2IV6AE?=
 =?us-ascii?Q?MLigiyiIYJZ5XxDic44tqWwG0nbTvZ0An4cPyZgbCvWCd0nHTAWywQvzkVxJ?=
 =?us-ascii?Q?odItLmMjpzYOKchl+ZKgBEZ4OzeZzUWb1+MQpwNZGYc0B/2bU5WzqKJDkPbD?=
 =?us-ascii?Q?q+1s+xgLcRDQc3IJSUFbzsheoYlbRAjwHLld6LzrvYRxBEDAjfLxYpfXE09g?=
 =?us-ascii?Q?c1A2h0IjS6p7vUa/aWZbPPuZh0tgolzLPs222PWmhoDMDRVQZh2Qnz7YtH2w?=
 =?us-ascii?Q?KXH9cBzaepqmo2hYTkyPykKjGdzMotdcF8N1YRFXHRT4GjRumM7CCG+Ko93l?=
 =?us-ascii?Q?v0rJSoy/sKiB+n8jAm+BnBqwbOgRtI0Jb6zTuPQDfF8cS+uLYIDfQFrilzbZ?=
 =?us-ascii?Q?8MWnLIQVTAEgLil9kNLhQ2WXIaLrUu3BosjrKsWjTL/NB5Fw9mH+GUdpnTpw?=
 =?us-ascii?Q?gRRY8K10Pxu87Ot7+qgHw0N5JiYBld6qNOoOXeJkCJWJqWsboouHIZK8Lerj?=
 =?us-ascii?Q?vdGC/+mDgCW5AHLR81xq+zLd3hsh7CbF27Kz13FVl+8nYMlBDDqQitso2uhu?=
 =?us-ascii?Q?emkwD5AScPAtl0KXI2Z7U9Atlu84r1FkfOaSOg3Nb1+PND1hiejrQ+mZm3h5?=
 =?us-ascii?Q?qn8beLrupesUZJi608GZAyplytf+gV/wusswoySOL/E8Fa05INtSIPaMmd+u?=
 =?us-ascii?Q?Kq1raqZkDlrobBMwGYOWlIDR+d0CGRANqV4lf5AgmWZeJ1XwA0wV5/LWpu7c?=
 =?us-ascii?Q?ivfX3DR643feSdzqW96pRbHCi77SITeuhCmNcNeHik5jtwN052RVJIHgRi8T?=
 =?us-ascii?Q?R/vd3dZ/Sh99Y8A3WaZT+RMf7rs/UIh3QFmIldLPnsd8PEtHdr9//nAyfshC?=
 =?us-ascii?Q?/aGZiWCpmKBEFcZzhgL4hDnntXbYUKnck38e0NUhtWjC1xMuMFDQKwpiWT2M?=
 =?us-ascii?Q?Hdmiv2jWse+0w1wNZcoLEgp73pvQ1X6K0TL7QTpBupknbxO/FgMpK1ot8ese?=
 =?us-ascii?Q?hNqn7WHBKsLgyeBDIHiMuMY/QReUIYlv9t36R0zibsZFAO0gIOQ0uNAjyajZ?=
 =?us-ascii?Q?b9yl6cf87mzNxI4mC1jytpM2oSOzmqvsiPBjMJQyBITL3fZsV4ggnd7XOyny?=
 =?us-ascii?Q?0k2BqtGSUQNkAlBgwBXem4G24wHdgdQ1K8gPL3Oy0dsE0GDsKBDmd0r3VmYO?=
 =?us-ascii?Q?m92P30l9eH6Mirx0nBtXcdiGTRumKJjVLGKQA6HYnJaulSomB9CkLG5TEiMP?=
 =?us-ascii?Q?Xw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <61B92BA0AFB77A4AA4AAF7A723A39A30@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd30f0fd-fbf5-4383-3e9d-08da9cda2054
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2022 20:36:28.4917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lSZQKASq6yBesoyEEfeRQ+bwokdY7cC6YAplBRbGK7EWHqR8b5GyuFzwi+brzj1NWjGSL+j/7VdWI1BiFA4uIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4374
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-22_14,2022-09-22_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=0 mlxlogscore=859 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209220132
X-Proofpoint-GUID: sgl2KGT6vKGvHuhED-9jsJR1E6TJGn3B
X-Proofpoint-ORIG-GUID: sgl2KGT6vKGvHuhED-9jsJR1E6TJGn3B
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi-

Jeff noticed my XDR tracepoints branch was getting stale. I've
rebased it on latest stable (v5.19).

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/log/?h=3Dtopi=
c-xdr-tracepoints

This adds nfsd_xdr and lockd_xdr subsystems. When enabled, they
record the arguments and results of each RPC request (NFSv3,
NFS3ACL, NFSv4, and NLM). It's noisy as hell, but I've posted
it for people to try out or even use to solve their issues.

Comments and opinions welcome.

--
Chuck Lever



