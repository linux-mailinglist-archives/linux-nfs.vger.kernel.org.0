Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315456787E3
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Jan 2023 21:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbjAWUej (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Jan 2023 15:34:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbjAWUeh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Jan 2023 15:34:37 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10BE87EF2
        for <linux-nfs@vger.kernel.org>; Mon, 23 Jan 2023 12:34:36 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30NKE0Kg014392;
        Mon, 23 Jan 2023 20:34:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=qVumoi+nIKg8ELx0IKS0wGMZ8QMTIv6lXCEj7LAH5VA=;
 b=AghO7KmadZGN9QflxLSF+Diswt/Uqcf+ejQmJThLETsSwE3UbAcrJpHp3NSyAZ2IecBG
 yq05lZUUTKsn4fsiGnW4iBbc9AueQaFW8Y7rF0vxJ4/QmGZVPgxNduUeElIdZqZiVxqH
 HjMBbQcyBlWpDqWNI8oGOWtIqvkNYxKQOT/gcjN+2THtk7LGM0Md3sXB8vX/tWNqJnJ8
 C3Kz5imzjM+n8/NEe4ZvwRxyB0e2oM5+Tvs0m0X+MB/zhrw4oJPXO3h2QgBWbJ08fmwQ
 fpEExvGYLaIw6Ec0ol7VlhNO3PfMNUzNykCfoWCuRfeP51W0xY5AuXER/dP3KvWWNY0d fQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n87nt3tqc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Jan 2023 20:34:28 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30NJKLUo023311;
        Mon, 23 Jan 2023 20:34:27 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n86g429a2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Jan 2023 20:34:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LE/5K+oFjw359Cr4gxAOx58Qv4TJZIPEXrGGj8QoU6hpoxtDQlTElUuaHUvqND3vQmyxVRiBWRUHCZx2gtsH2hDfqfkV4Ziq0cIltShEbyoS4qQxwoBAYuaBsJvNgkLkJ5Np6BaL+m0RSqqHx+GgF6DQiY2dtI1c/Lp84j4aUwBaopirXn6MKdfa8Kfk3yy9kBYvV3CzghsGs+0LumJTncdpMZA+TNx/Ht9TbSu9J4UfK9WpGx/c2AJURLLd8buj6fmE9q8tekGk8hZ3II1mm6trM1NQKTvDkWqdHHX9ZWbC2wVW78VVzTUt75bJY/LbaAvAXKbmVp1F+jNawTQQdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qVumoi+nIKg8ELx0IKS0wGMZ8QMTIv6lXCEj7LAH5VA=;
 b=kuM6X/F5zGa9K0vawpkfykPqd8iacuqllCIzMg6f0GrXVR5kenc3dWh1G7wNpug0xv3VT63KHBBv1r6vGKgJ8K4mXG79Vl5QmUeamcRnoHHgouBpraNYrNQVBksgUhF3TdscSwAVGxCcFozLfFjHSK+gh79WUEA/g9Tq+Som7Pd89E3S7sZevvZKlJygHA9z9HCrKxuIuhuD5Hnta/n8bazhIe+5S6BCfALk84HgXYaZBu9HKGff/dHuexolrdW5OUrIVXPD2Rn7KXbSVlW6kHsVxrWcpXaRpRnbpOblU2P28i1X10TC4ctrE88uVfbhEYsXxnL3tRuHY7WcVqs2FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qVumoi+nIKg8ELx0IKS0wGMZ8QMTIv6lXCEj7LAH5VA=;
 b=aQA6i8l/jTUO3rrTJfSvKgWJs2eyRC4w0pyINjafQFdAi/FJlbUuxJpeGWGdHXHoe+rWKgmTvAk5Y4XCpSh2R24mSapgnOyq3KeE4bsUOVExoPhTvdGrn6yIeqTLzdFoCuz9f9J3ztZxpfj1s0ljoOZ4qLofh1Xcjs1ypvJbBnM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY5PR10MB6047.namprd10.prod.outlook.com (2603:10b6:930:3c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.16; Mon, 23 Jan
 2023 20:34:25 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9%6]) with mapi id 15.20.6043.016; Mon, 23 Jan 2023
 20:34:25 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@redhat.com>
CC:     Chuck Lever <cel@kernel.org>, Neil Brown <neilb@suse.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH RFC] NFSD: Convert filecache to rhltable
Thread-Topic: [PATCH RFC] NFSD: Convert filecache to rhltable
Thread-Index: AQHZIRZdLVddJev/70WpowDSuI8Nnq6sjLEAgAAFSwA=
Date:   Mon, 23 Jan 2023 20:34:25 +0000
Message-ID: <FB44286A-6F2C-4E41-BF22-E0FB8F2F524D@oracle.com>
References: <167293053710.2587608.15966496749656663379.stgit@manet.1015granger.net>
 <d65c6afc3f1dfd29e7cc46e1bd00b458c3f0d2f8.camel@redhat.com>
In-Reply-To: <d65c6afc3f1dfd29e7cc46e1bd00b458c3f0d2f8.camel@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CY5PR10MB6047:EE_
x-ms-office365-filtering-correlation-id: 0c283cb6-b5b2-4451-9dac-08dafd813797
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PRxnd8QXy1y/9T35RLsvAAWFZ6rLm4Mp5h7hc8ZKOKTOCJymhZf8vZhHV3X7WX3ecHln0cl0FzGlkuROQVnvFaNkUibqoK7S9cyDad3+g5vxh/YMAZYvV9YrVQpD7ix1c2eNVgQT9A9M/aLXbIjqkaAZ3rzi8IxKmyUlHG3TfELAuLD34Qb1ww5wnCb+A/HhXMGlodu/LzkTedFMQ3O6AJuaFQA9D6LGsWSKY0USpvZvwwJRE6eqOzSjDHRNN9pW5Qbbt6FNPiZ632WRlq9rFziQNNTyIaRyCwqFTCZwM7ikTRpckur3V68NZWr2kvBzrGqUGmbbwIgMnpLZegEG/Wbb49mONJKteIWEHxClLDOUulKVB09MzWbQtHpyYebYDNE1ClZe985XON3m6scRpLp5EkcouwqeEU5booNjdOYf8T5tgokwspFQAlUyXEz6TsQqByEQJXCVo3Tk75JoSOCEDWW4smjz/59Mpn6U34yHK21ojkYUp1nvtApmjPWDys/9piHGdvQVCc4b+wvDg37Kv4TKx2HQkJtLJ3mdKZ5O4ueACWIXCej6JGAPmzlCWVHi14s5F4CI8StYTFMbcoV4iOTcq06hqxyfs52pygoHP/Y2ZvHX93Yqn/FuZPBg0GBrgNBiy+UolMYt5W9TIwgDRMJrpwqH6d9ijxDSRUFUilndD8zmlVpry2AH+c+kOVyUB3rtxpKEXjPdPpGJS9cwIwIKheTt0Vb5xPLcmGM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(346002)(396003)(376002)(136003)(451199015)(38070700005)(36756003)(33656002)(86362001)(316002)(2616005)(54906003)(66556008)(66476007)(91956017)(66446008)(122000001)(76116006)(26005)(186003)(6486002)(478600001)(6512007)(6506007)(71200400001)(66946007)(53546011)(38100700002)(64756008)(8936002)(83380400001)(41300700001)(2906002)(4326008)(8676002)(6916009)(5660300002)(30864003)(45980500001)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?genlIW5i8/1nJRnaC28pi24m+i4qOp3sVjmINv3afYEAl/rCqbPUxmcdl1SL?=
 =?us-ascii?Q?ZvhHag6G2J0e4+shTA2A0j8zGSZ9/J09+nGCe7jYm21zrPSZSJwiBpphDnze?=
 =?us-ascii?Q?XhqZWG6viUaOV1XxyR67WOgofOFPHA16F/E3HvdwxPVwRfELKBEqGqFDbuzp?=
 =?us-ascii?Q?rj9+EP68+n5z4suCS4uu3ni0NKsvBNOuNlxyC0q1lMTDmO2uDCLUL4fh/SbZ?=
 =?us-ascii?Q?6giTpZbSxRk8BYtjjkrwzkpmTeaWFntq/piTYP0l60WzRJaixXMjrbkgN2i5?=
 =?us-ascii?Q?7Egynz8OPuun0n7TdERob97jW30AecvfU1CddCkBkLRGTDEHIkT/2JoBFdCR?=
 =?us-ascii?Q?v+WWubpOw4jRUq5tuW7e7ktH0vFjzbK7mu44suXtt5e2UBDE1gzvHkcXQAnj?=
 =?us-ascii?Q?U3AgYiE9/Rgsdo1cO8fkgGtUIxwWiJRmRCYPIuArdoW6iSZlZUi9HOYXjfFH?=
 =?us-ascii?Q?m/Al/Y3yP9iIeivAY2Ehj0t7U6nDGN04WgxS18eywD8H/WvXkbVYeCrYPd4+?=
 =?us-ascii?Q?zE9ObBI/aDKFWlNommnVn+kdtepYTRhN5/zU/KtAUr5a1VdmKVbaG2y6cOVF?=
 =?us-ascii?Q?FYA55oR4RdGT0KOkKxxQZ7oGJVhY3QcD0fhZo4zlnqHVGA40I3PLgqABxYdQ?=
 =?us-ascii?Q?k96p52z1OyXNVF+V3WBqNj7IReagzmtSGJIFDyeCKvKoD7THfmcsCyDjesxU?=
 =?us-ascii?Q?BK2WY4O7WGHiSE9R/QxF+6y13IMMwk26mnyf13cdbChNzGkEtEsFkcZ8TaeW?=
 =?us-ascii?Q?vhst1fIZTFpkxJjHFoeRn84/T4kA50tfySz0aAiD2eEjIfyj3w01m1gWDrrq?=
 =?us-ascii?Q?6cjsdGKj6fEmENfpBimarb9POcu7myRVvfhcJ/EKuA2ogWBjZfr+1CMjyMCV?=
 =?us-ascii?Q?l+nOysD55NLzOg/2oeZhW3ovprJvin0PUp//xidN0WgVBO0+UJZ79TxM9D5Z?=
 =?us-ascii?Q?8x+3gFzkImJ/cSPpD30Bkw4scu3XplNJ9ubOQGrFmv+QM2KMqWySQ9YRKlmG?=
 =?us-ascii?Q?AMYgAq5jm9oI6enbDo/cnexky6IzY4B1rnU1mF7/cMXMOaHkh7LU7PW9cFKf?=
 =?us-ascii?Q?+4YHEZaIK6eSQ58h8kao8qBACLTJLmIIsxOBpW22Jw8xXiu9EVBi35igRJVQ?=
 =?us-ascii?Q?0KjZt+cIMSNztwIh52bcJN+XnGc2jQZO9LYJa1uvayroBrqvqcoVEfE7nXm5?=
 =?us-ascii?Q?rgV75prLXMn+i8Pja5yyjYJNfWLG1kLh4/l/mUYe1X4jieFaBbfhe8WiK7yM?=
 =?us-ascii?Q?3fXlKSI3vccGl3IQmx4XRTyB2TYqB445/tr8lSI+JStsKbNrTQrpCZd82Uze?=
 =?us-ascii?Q?4Eq/4s9ZUQ1hYsBWSP6hxrWtxwaXEJyiNd20Tbii6kFUELtEyank0+y6vk2I?=
 =?us-ascii?Q?5nTLKqvkmwdHiZCacNv/aUQ4lmVgHJf/Z92oiHoFR3EHBBsXuUSHH3s1OWcS?=
 =?us-ascii?Q?zTX2qT/B3NmwIqEhxyokyfewUlMNuuylDZkngA+oL5BsmDWNtLUjEyAzDhXb?=
 =?us-ascii?Q?Lgc9fnJTXpP4hGxsxhTtB1QalXj2h/nO9FsC7ohlr7+0955W2xkFQlFB6Ik2?=
 =?us-ascii?Q?plCDBav1cAlHPjxUTnPYQRF32CEgZ5IsSRYhOOCuTz5+6w3zWDRN5GnifGSo?=
 =?us-ascii?Q?6w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E3605CA798029941B9EC4FF92C10F619@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2CgJ+zjEG9CjhihmjzgXvategAGsvv4QV+gtNoc3Lugo0HLWPFJidi5dc5CoQQOnoTijPnYRQ8PoFQojlE8mg9EhLj/T9V/4osM7r8ZKPiQ9otFaU2XkKnHCs4kzj9jnV7TNRC6ODjVxjghjUL5psSrArPXY7PJ+4Im4+vCzm6UxNRP37WxW18DNor+HmjxYXuA4L83JX89G3bC0s44T9uvLpWlsj7BtGtJib26U1B/WGeNs6u4I1Iwdy7jac+pvdCiiq6L4sRgKk8auwUYNY4geKkL3FOU/IjK6ccCAvja+q9O3pbE3oSh0WcaY4prs3uGfAsr6d8P+Wm9SHSxXT3ToL8cPnYjBA89xKnNCT8vxuut5nGhXSybE8dWKS5Yf+q4j9K7rRVrxBULt7MmZMnY929zN0zTpjS0sxjcQyNSnC1v3vI3UK+IwdNzlWoYcPVsGdmKUsOKclsYLTl3aDtDNTe5inW7BwdK8MfYfgouLnpI27x4nfN8NxB1z4DihUlyagHXlXn8PNZ4oamGT8sxCnJhPPgqbpAfpwy00SyeBp7IfY6lI6pxWIFtusB6E+c3MLTjoEBREgb8LPZ+upOpLkWiapkwz08DX2FkVM8LFqU1tJI7iGw1C4gNKXJDnlIG+HODd1SKiajsa0rthy/nFeK+RQGCsujBUo56vjZGyvMSc0SXfEj37qJHXSJtuKyiWmEIGyOuhLL+VHP7+WbpW5n1LSwkFwInunX55JoARSTeuCQrm4XDr01nTmJ9wDmpw0F6v5IqJZIIaT406ZC+s2gxPDf1UIKeBAZMFY5iNC2mYeoNlDRG/vUmomGyyQ5W58qs9kA8pLbMQsQ/OJQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c283cb6-b5b2-4451-9dac-08dafd813797
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2023 20:34:25.1482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6I7DVMjaJ7kOWNGK3U+61lyvhm4YkrHt/BdKuiyepIudCXkVZqcVaudt8pignONwstZRKpt8yQ6XDUHBTOFPuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6047
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_12,2023-01-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301230195
X-Proofpoint-ORIG-GUID: LK2Nk8nhTmTCCLJ_h_51pdV7NaGqlV97
X-Proofpoint-GUID: LK2Nk8nhTmTCCLJ_h_51pdV7NaGqlV97
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 23, 2023, at 3:15 PM, Jeff Layton <jlayton@redhat.com> wrote:
>=20
> On Thu, 2023-01-05 at 09:58 -0500, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>=20
>> While we were converting the nfs4_file hashtable to use the kernel's
>> resizable hashtable data structure, Neil Brown observed that the
>> list variant (rhltable) would be better for managing nfsd_file items
>> as well. The nfsd_file hash table will contain multiple entries for
>> the same inode -- these should be kept together on a list. And, it
>> could be possible for exotic or malicious client behavior to cause
>> the hash table to resize itself on every insertion.
>>=20
>> A nice simplification is that rhltable_lookup() can return a list
>> that contains only nfsd_file items that match a given inode, which
>> enables us to eliminate specialized hash table helper functions and
>> use the default functions provided by the rhashtable implementation).
>>=20
>> Since we are now storing nfsd_file items for the same inode on a
>> single list, that effectively reduces the number of hash entries
>> that have to be tracked in the hash table. The mininum bucket count
>> is therefore lowered.
>>=20
>> Suggested-by: Neil Brown <neilb@suse.de>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> fs/nfsd/filecache.c |  289 +++++++++++++++++++--------------------------=
------
>> fs/nfsd/filecache.h |    9 +-
>> 2 files changed, 115 insertions(+), 183 deletions(-)
>>=20
>> Just to note that this work is still in the wings. It would need to
>> be rebased on Jeff's recent fixes and clean-ups. I'm reluctant to
>> apply this until there is more evidence that the instability in v6.0
>> has been duly addressed.
>>=20
>>=20
>> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
>> index 45b2c9e3f636..f04e722bb6bc 100644
>> --- a/fs/nfsd/filecache.c
>> +++ b/fs/nfsd/filecache.c
>> @@ -74,70 +74,9 @@ static struct list_lru			nfsd_file_lru;
>> static unsigned long			nfsd_file_flags;
>> static struct fsnotify_group		*nfsd_file_fsnotify_group;
>> static struct delayed_work		nfsd_filecache_laundrette;
>> -static struct rhashtable		nfsd_file_rhash_tbl
>> +static struct rhltable			nfsd_file_rhltable
>> 						____cacheline_aligned_in_smp;
>>=20
>> -enum nfsd_file_lookup_type {
>> -	NFSD_FILE_KEY_INODE,
>> -	NFSD_FILE_KEY_FULL,
>> -};
>> -
>> -struct nfsd_file_lookup_key {
>> -	struct inode			*inode;
>> -	struct net			*net;
>> -	const struct cred		*cred;
>> -	unsigned char			need;
>> -	bool				gc;
>> -	enum nfsd_file_lookup_type	type;
>> -};
>> -
>> -/*
>> - * The returned hash value is based solely on the address of an in-code
>> - * inode, a pointer to a slab-allocated object. The entropy in such a
>> - * pointer is concentrated in its middle bits.
>> - */
>> -static u32 nfsd_file_inode_hash(const struct inode *inode, u32 seed)
>> -{
>> -	unsigned long ptr =3D (unsigned long)inode;
>> -	u32 k;
>> -
>> -	k =3D ptr >> L1_CACHE_SHIFT;
>> -	k &=3D 0x00ffffff;
>> -	return jhash2(&k, 1, seed);
>> -}
>> -
>> -/**
>> - * nfsd_file_key_hashfn - Compute the hash value of a lookup key
>> - * @data: key on which to compute the hash value
>> - * @len: rhash table's key_len parameter (unused)
>> - * @seed: rhash table's random seed of the day
>> - *
>> - * Return value:
>> - *   Computed 32-bit hash value
>> - */
>> -static u32 nfsd_file_key_hashfn(const void *data, u32 len, u32 seed)
>> -{
>> -	const struct nfsd_file_lookup_key *key =3D data;
>> -
>> -	return nfsd_file_inode_hash(key->inode, seed);
>> -}
>> -
>> -/**
>> - * nfsd_file_obj_hashfn - Compute the hash value of an nfsd_file
>> - * @data: object on which to compute the hash value
>> - * @len: rhash table's key_len parameter (unused)
>> - * @seed: rhash table's random seed of the day
>> - *
>> - * Return value:
>> - *   Computed 32-bit hash value
>> - */
>> -static u32 nfsd_file_obj_hashfn(const void *data, u32 len, u32 seed)
>> -{
>> -	const struct nfsd_file *nf =3D data;
>> -
>> -	return nfsd_file_inode_hash(nf->nf_inode, seed);
>> -}
>> -
>> static bool
>> nfsd_match_cred(const struct cred *c1, const struct cred *c2)
>> {
>> @@ -158,53 +97,16 @@ nfsd_match_cred(const struct cred *c1, const struct=
 cred *c2)
>> 	return true;
>> }
>>=20
>> -/**
>> - * nfsd_file_obj_cmpfn - Match a cache item against search criteria
>> - * @arg: search criteria
>> - * @ptr: cache item to check
>> - *
>> - * Return values:
>> - *   %0 - Item matches search criteria
>> - *   %1 - Item does not match search criteria
>> - */
>> -static int nfsd_file_obj_cmpfn(struct rhashtable_compare_arg *arg,
>> -			       const void *ptr)
>> -{
>> -	const struct nfsd_file_lookup_key *key =3D arg->key;
>> -	const struct nfsd_file *nf =3D ptr;
>> -
>> -	switch (key->type) {
>> -	case NFSD_FILE_KEY_INODE:
>> -		if (nf->nf_inode !=3D key->inode)
>> -			return 1;
>> -		break;
>> -	case NFSD_FILE_KEY_FULL:
>> -		if (nf->nf_inode !=3D key->inode)
>> -			return 1;
>> -		if (nf->nf_may !=3D key->need)
>> -			return 1;
>> -		if (nf->nf_net !=3D key->net)
>> -			return 1;
>> -		if (!nfsd_match_cred(nf->nf_cred, key->cred))
>> -			return 1;
>> -		if (!!test_bit(NFSD_FILE_GC, &nf->nf_flags) !=3D key->gc)
>> -			return 1;
>> -		if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags) =3D=3D 0)
>> -			return 1;
>> -		break;
>> -	}
>> -	return 0;
>> -}
>> -
>> static const struct rhashtable_params nfsd_file_rhash_params =3D {
>> 	.key_len		=3D sizeof_field(struct nfsd_file, nf_inode),
>> 	.key_offset		=3D offsetof(struct nfsd_file, nf_inode),
>> -	.head_offset		=3D offsetof(struct nfsd_file, nf_rhash),
>> -	.hashfn			=3D nfsd_file_key_hashfn,
>> -	.obj_hashfn		=3D nfsd_file_obj_hashfn,
>> -	.obj_cmpfn		=3D nfsd_file_obj_cmpfn,
>> -	/* Reduce resizing churn on light workloads */
>> -	.min_size		=3D 512,		/* buckets */
>> +	.head_offset		=3D offsetof(struct nfsd_file, nf_rlist),
>> +
>> +	/*
>> +	 * Start with a single page hash table to reduce resizing churn
>> +	 * on light workloads.
>> +	 */
>> +	.min_size		=3D 256,
>> 	.automatic_shrinking	=3D true,
>> };
>>=20
>> @@ -307,27 +209,27 @@ nfsd_file_mark_find_or_create(struct nfsd_file *nf=
, struct inode *inode)
>> }
>>=20
>> static struct nfsd_file *
>> -nfsd_file_alloc(struct nfsd_file_lookup_key *key, unsigned int may)
>> +nfsd_file_alloc(struct net *net, struct inode *inode, unsigned char nee=
d,
>> +		bool want_gc)
>> {
>> 	struct nfsd_file *nf;
>>=20
>> 	nf =3D kmem_cache_alloc(nfsd_file_slab, GFP_KERNEL);
>> -	if (nf) {
>> -		INIT_LIST_HEAD(&nf->nf_lru);
>> -		nf->nf_birthtime =3D ktime_get();
>> -		nf->nf_file =3D NULL;
>> -		nf->nf_cred =3D get_current_cred();
>> -		nf->nf_net =3D key->net;
>> -		nf->nf_flags =3D 0;
>> -		__set_bit(NFSD_FILE_HASHED, &nf->nf_flags);
>> -		__set_bit(NFSD_FILE_PENDING, &nf->nf_flags);
>> -		if (key->gc)
>> -			__set_bit(NFSD_FILE_GC, &nf->nf_flags);
>> -		nf->nf_inode =3D key->inode;
>> -		refcount_set(&nf->nf_ref, 1);
>> -		nf->nf_may =3D key->need;
>> -		nf->nf_mark =3D NULL;
>> -	}
>> +	if (unlikely(!nf))
>> +		return NULL;
>> +
>> +	INIT_LIST_HEAD(&nf->nf_lru);
>> +	nf->nf_birthtime =3D ktime_get();
>> +	nf->nf_file =3D NULL;
>> +	nf->nf_cred =3D get_current_cred();
>> +	nf->nf_net =3D net;
>> +	nf->nf_flags =3D want_gc ?
>> +		BIT(NFSD_FILE_HASHED) | BIT(NFSD_FILE_PENDING) | BIT(NFSD_FILE_GC) :
>> +		BIT(NFSD_FILE_HASHED) | BIT(NFSD_FILE_PENDING);
>> +	nf->nf_inode =3D inode;
>> +	refcount_set(&nf->nf_ref, 1);
>> +	nf->nf_may =3D need;
>> +	nf->nf_mark =3D NULL;
>> 	return nf;
>> }
>>=20
>> @@ -362,8 +264,8 @@ nfsd_file_hash_remove(struct nfsd_file *nf)
>>=20
>> 	if (nfsd_file_check_write_error(nf))
>> 		nfsd_reset_write_verifier(net_generic(nf->nf_net, nfsd_net_id));
>> -	rhashtable_remove_fast(&nfsd_file_rhash_tbl, &nf->nf_rhash,
>> -			       nfsd_file_rhash_params);
>> +	rhltable_remove(&nfsd_file_rhltable, &nf->nf_rlist,
>> +			nfsd_file_rhash_params);
>> }
>>=20
>> static bool
>> @@ -680,21 +582,19 @@ static struct shrinker	nfsd_file_shrinker =3D {
>> static void
>> nfsd_file_queue_for_close(struct inode *inode, struct list_head *dispose=
)
>> {
>> -	struct nfsd_file_lookup_key key =3D {
>> -		.type	=3D NFSD_FILE_KEY_INODE,
>> -		.inode	=3D inode,
>> -	};
>> -	struct nfsd_file *nf;
>> -
>> 	rcu_read_lock();
>> 	do {
>> +		struct rhlist_head *list;
>> +		struct nfsd_file *nf;
>> 		int decrement =3D 1;
>>=20
>> -		nf =3D rhashtable_lookup(&nfsd_file_rhash_tbl, &key,
>> +		list =3D rhltable_lookup(&nfsd_file_rhltable, &inode,
>> 				       nfsd_file_rhash_params);
>> -		if (!nf)
>> +		if (!list)
>> 			break;
>>=20
>=20
> Rather than redriving the lookup multiple times in the loop, would it be
> better to just search once and then walk the resulting list with
> rhl_for_each_entry_rcu, all while holding the rcu_read_lock?

That would be nice, but as you and I have discussed before:

On every iteration, we're possibly calling nfsd_file_unhash(), which
changes the list. So we have to invoke rhltable_lookup() again to get
the updated version of that list.

As far as I can see there's no "_safe" version of rhl_for_each_entry.

I think the best we can do is not redrive the lookup if we didn't
unhash anything. I'm not sure that will fit easily with the
nfsd_file_cond_queue thingie you just added in nfsd-fixes.

Perhaps it should also drop the RCU read lock on each iteration in
case it finds a lot of inodes that match the lookup criteria.


>> +		nf =3D container_of(list, struct nfsd_file, nf_rlist);
>> +
>> 		/* If we raced with someone else unhashing, ignore it */
>> 		if (!nfsd_file_unhash(nf))
>> 			continue;
>> @@ -836,7 +736,7 @@ nfsd_file_cache_init(void)
>> 	if (test_and_set_bit(NFSD_FILE_CACHE_UP, &nfsd_file_flags) =3D=3D 1)
>> 		return 0;
>>=20
>> -	ret =3D rhashtable_init(&nfsd_file_rhash_tbl, &nfsd_file_rhash_params)=
;
>> +	ret =3D rhltable_init(&nfsd_file_rhltable, &nfsd_file_rhash_params);
>> 	if (ret)
>> 		return ret;
>>=20
>> @@ -904,7 +804,7 @@ nfsd_file_cache_init(void)
>> 	nfsd_file_mark_slab =3D NULL;
>> 	destroy_workqueue(nfsd_filecache_wq);
>> 	nfsd_filecache_wq =3D NULL;
>> -	rhashtable_destroy(&nfsd_file_rhash_tbl);
>> +	rhltable_destroy(&nfsd_file_rhltable);
>> 	goto out;
>> }
>>=20
>> @@ -922,7 +822,7 @@ __nfsd_file_cache_purge(struct net *net)
>> 	struct nfsd_file *nf;
>> 	LIST_HEAD(dispose);
>>=20
>> -	rhashtable_walk_enter(&nfsd_file_rhash_tbl, &iter);
>> +	rhltable_walk_enter(&nfsd_file_rhltable, &iter);
>> 	do {
>> 		rhashtable_walk_start(&iter);
>>=20
>> @@ -1031,7 +931,7 @@ nfsd_file_cache_shutdown(void)
>> 	nfsd_file_mark_slab =3D NULL;
>> 	destroy_workqueue(nfsd_filecache_wq);
>> 	nfsd_filecache_wq =3D NULL;
>> -	rhashtable_destroy(&nfsd_file_rhash_tbl);
>> +	rhltable_destroy(&nfsd_file_rhltable);
>>=20
>> 	for_each_possible_cpu(i) {
>> 		per_cpu(nfsd_file_cache_hits, i) =3D 0;
>> @@ -1042,6 +942,36 @@ nfsd_file_cache_shutdown(void)
>> 	}
>> }
>>=20
>> +static struct nfsd_file *
>> +nfsd_file_lookup_locked(const struct net *net, const struct cred *cred,
>> +			struct inode *inode, unsigned char need,
>> +			bool want_gc)
>> +{
>> +	struct rhlist_head *tmp, *list;
>> +	struct nfsd_file *nf;
>> +
>> +	list =3D rhltable_lookup(&nfsd_file_rhltable, &inode,
>> +			       nfsd_file_rhash_params);
>> +	rhl_for_each_entry_rcu(nf, tmp, list, nf_rlist) {
>> +		if (nf->nf_may !=3D need)
>> +			continue;
>> +		if (nf->nf_net !=3D net)
>> +			continue;
>> +		if (!nfsd_match_cred(nf->nf_cred, cred))
>> +			continue;
>> +		if (!!test_bit(NFSD_FILE_GC, &nf->nf_flags) !=3D want_gc)
>> +			continue;
>> +		if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags) =3D=3D 0)
>> +			continue;
>> +
>> +		/* If it was on the LRU, reuse that reference. */
>> +		if (nfsd_file_lru_remove(nf))
>> +			WARN_ON_ONCE(refcount_dec_and_test(&nf->nf_ref));
>> +		return nf;
>> +	}
>> +	return NULL;
>> +}
>> +
>> /**
>>  * nfsd_file_is_cached - are there any cached open files for this inode?
>>  * @inode: inode to check
>> @@ -1056,15 +986,12 @@ nfsd_file_cache_shutdown(void)
>> bool
>> nfsd_file_is_cached(struct inode *inode)
>> {
>> -	struct nfsd_file_lookup_key key =3D {
>> -		.type	=3D NFSD_FILE_KEY_INODE,
>> -		.inode	=3D inode,
>> -	};
>> -	bool ret =3D false;
>> -
>> -	if (rhashtable_lookup_fast(&nfsd_file_rhash_tbl, &key,
>> -				   nfsd_file_rhash_params) !=3D NULL)
>> -		ret =3D true;
>> +	bool ret;
>> +
>> +	rcu_read_lock();
>> +	ret =3D (rhltable_lookup(&nfsd_file_rhltable, &inode,
>> +			       nfsd_file_rhash_params) !=3D NULL);
>> +	rcu_read_unlock();
>> 	trace_nfsd_file_is_cached(inode, (int)ret);
>> 	return ret;
>> }
>> @@ -1074,14 +1001,12 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, str=
uct svc_fh *fhp,
>> 		     unsigned int may_flags, struct nfsd_file **pnf,
>> 		     bool open, bool want_gc)
>> {
>> -	struct nfsd_file_lookup_key key =3D {
>> -		.type	=3D NFSD_FILE_KEY_FULL,
>> -		.need	=3D may_flags & NFSD_FILE_MAY_MASK,
>> -		.net	=3D SVC_NET(rqstp),
>> -		.gc	=3D want_gc,
>> -	};
>> +	unsigned char need =3D may_flags & NFSD_FILE_MAY_MASK;
>> +	struct net *net =3D SVC_NET(rqstp);
>> +	struct nfsd_file *new, *nf;
>> +	const struct cred *cred;
>> 	bool open_retry =3D true;
>> -	struct nfsd_file *nf;
>> +	struct inode *inode;
>> 	__be32 status;
>> 	int ret;
>>=20
>> @@ -1089,32 +1014,38 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, str=
uct svc_fh *fhp,
>> 				may_flags|NFSD_MAY_OWNER_OVERRIDE);
>> 	if (status !=3D nfs_ok)
>> 		return status;
>> -	key.inode =3D d_inode(fhp->fh_dentry);
>> -	key.cred =3D get_current_cred();
>> +	inode =3D d_inode(fhp->fh_dentry);
>> +	cred =3D get_current_cred();
>>=20
>> retry:
>> -	rcu_read_lock();
>> -	nf =3D rhashtable_lookup(&nfsd_file_rhash_tbl, &key,
>> -			       nfsd_file_rhash_params);
>> -	if (nf)
>> -		nf =3D nfsd_file_get(nf);
>> -	rcu_read_unlock();
>> -
>> -	if (nf) {
>> -		if (nfsd_file_lru_remove(nf))
>> -			WARN_ON_ONCE(refcount_dec_and_test(&nf->nf_ref));
>> -		goto wait_for_construction;
>> +	if (open) {
>> +		rcu_read_lock();
>> +		nf =3D nfsd_file_lookup_locked(net, cred, inode, need, want_gc);
>> +		rcu_read_unlock();
>> +		if (nf)
>> +			goto wait_for_construction;
>> 	}
>>=20
>> -	nf =3D nfsd_file_alloc(&key, may_flags);
>> -	if (!nf) {
>> +	new =3D nfsd_file_alloc(net, inode, need, want_gc);
>> +	if (!new) {
>> 		status =3D nfserr_jukebox;
>> 		goto out_status;
>> 	}
>> +	rcu_read_lock();
>> +	spin_lock(&inode->i_lock);
>> +	nf =3D nfsd_file_lookup_locked(net, cred, inode, need, want_gc);
>> +	if (unlikely(nf)) {
>> +		spin_unlock(&inode->i_lock);
>> +		rcu_read_unlock();
>> +		nfsd_file_slab_free(&new->nf_rcu);
>> +		goto wait_for_construction;
>> +	}
>> +	nf =3D new;
>> +	ret =3D rhltable_insert(&nfsd_file_rhltable, &nf->nf_rlist,
>> +			      nfsd_file_rhash_params);
>> +	spin_unlock(&inode->i_lock);
>> +	rcu_read_unlock();
>>=20
>> -	ret =3D rhashtable_lookup_insert_key(&nfsd_file_rhash_tbl,
>> -					   &key, &nf->nf_rhash,
>> -					   nfsd_file_rhash_params);
>> 	if (likely(ret =3D=3D 0))
>> 		goto open_file;
>>=20
>> @@ -1122,7 +1053,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struc=
t svc_fh *fhp,
>> 	nf =3D NULL;
>> 	if (ret =3D=3D -EEXIST)
>> 		goto retry;
>> -	trace_nfsd_file_insert_err(rqstp, key.inode, may_flags, ret);
>> +	trace_nfsd_file_insert_err(rqstp, inode, may_flags, ret);
>> 	status =3D nfserr_jukebox;
>> 	goto out_status;
>>=20
>> @@ -1131,7 +1062,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struc=
t svc_fh *fhp,
>>=20
>> 	/* Did construction of this file fail? */
>> 	if (!test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
>> -		trace_nfsd_file_cons_err(rqstp, key.inode, may_flags, nf);
>> +		trace_nfsd_file_cons_err(rqstp, inode, may_flags, nf);
>> 		if (!open_retry) {
>> 			status =3D nfserr_jukebox;
>> 			goto out;
>> @@ -1157,14 +1088,14 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, str=
uct svc_fh *fhp,
>> 	}
>>=20
>> out_status:
>> -	put_cred(key.cred);
>> +	put_cred(cred);
>> 	if (open)
>> -		trace_nfsd_file_acquire(rqstp, key.inode, may_flags, nf, status);
>> +		trace_nfsd_file_acquire(rqstp, inode, may_flags, nf, status);
>> 	return status;
>>=20
>> open_file:
>> 	trace_nfsd_file_alloc(nf);
>> -	nf->nf_mark =3D nfsd_file_mark_find_or_create(nf, key.inode);
>> +	nf->nf_mark =3D nfsd_file_mark_find_or_create(nf, inode);
>> 	if (nf->nf_mark) {
>> 		if (open) {
>> 			status =3D nfsd_open_verified(rqstp, fhp, may_flags,
>> @@ -1178,7 +1109,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struc=
t svc_fh *fhp,
>> 	 * If construction failed, or we raced with a call to unlink()
>> 	 * then unhash.
>> 	 */
>> -	if (status =3D=3D nfs_ok && key.inode->i_nlink =3D=3D 0)
>> +	if (status !=3D nfs_ok || inode->i_nlink =3D=3D 0)
>> 		status =3D nfserr_jukebox;
>> 	if (status !=3D nfs_ok)
>> 		nfsd_file_unhash(nf);
>> @@ -1273,7 +1204,7 @@ int nfsd_file_cache_stats_show(struct seq_file *m,=
 void *v)
>> 		lru =3D list_lru_count(&nfsd_file_lru);
>>=20
>> 		rcu_read_lock();
>> -		ht =3D &nfsd_file_rhash_tbl;
>> +		ht =3D &nfsd_file_rhltable.ht;
>> 		count =3D atomic_read(&ht->nelems);
>> 		tbl =3D rht_dereference_rcu(ht->tbl, ht);
>> 		buckets =3D tbl->size;
>> @@ -1289,7 +1220,7 @@ int nfsd_file_cache_stats_show(struct seq_file *m,=
 void *v)
>> 		evictions +=3D per_cpu(nfsd_file_evictions, i);
>> 	}
>>=20
>> -	seq_printf(m, "total entries: %u\n", count);
>> +	seq_printf(m, "total inodes: %u\n", count);
>> 	seq_printf(m, "hash buckets:  %u\n", buckets);
>> 	seq_printf(m, "lru entries:   %lu\n", lru);
>> 	seq_printf(m, "cache hits:    %lu\n", hits);
>> diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
>> index b7efb2c3ddb1..7d3b35771565 100644
>> --- a/fs/nfsd/filecache.h
>> +++ b/fs/nfsd/filecache.h
>> @@ -29,9 +29,8 @@ struct nfsd_file_mark {
>>  * never be dereferenced, only used for comparison.
>>  */
>> struct nfsd_file {
>> -	struct rhash_head	nf_rhash;
>> -	struct list_head	nf_lru;
>> -	struct rcu_head		nf_rcu;
>> +	struct rhlist_head	nf_rlist;
>> +	void			*nf_inode;
>> 	struct file		*nf_file;
>> 	const struct cred	*nf_cred;
>> 	struct net		*nf_net;
>> @@ -40,10 +39,12 @@ struct nfsd_file {
>> #define NFSD_FILE_REFERENCED	(2)
>> #define NFSD_FILE_GC		(3)
>> 	unsigned long		nf_flags;
>> -	struct inode		*nf_inode;	/* don't deref */
>> 	refcount_t		nf_ref;
>> 	unsigned char		nf_may;
>> +
>> 	struct nfsd_file_mark	*nf_mark;
>> +	struct list_head	nf_lru;
>> +	struct rcu_head		nf_rcu;
>> 	ktime_t			nf_birthtime;
>> };
>>=20
>>=20
>>=20
>=20
> --=20
> Jeff Layton <jlayton@redhat.com>

--
Chuck Lever



