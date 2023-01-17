Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6EA766E205
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Jan 2023 16:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjAQPYR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 17 Jan 2023 10:24:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233616AbjAQPXt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 17 Jan 2023 10:23:49 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9C441B48
        for <linux-nfs@vger.kernel.org>; Tue, 17 Jan 2023 07:23:02 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30HFG8qF001750;
        Tue, 17 Jan 2023 15:22:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=7TTu95h8C7sBRXS8euCUb1uZyPb5NZcAWXH6Ol6pIwg=;
 b=RkCfbQyAWVZQXmYWBMwuJ2IjR3AgtXHatKCAnE5HevsC8i/Ii6BZfkamW8cD2WSBm9fV
 w8xdMsrxYAHQGNnKN4/JSOPhP7OjgZDlAB/BoLaX4d5MFpHb5JFrrHhi2XqzdGmHTa8X
 QzA6vu9Qvr/jxBAuG4ytvPM5ufPRwrkB4cVHODcX8Pj3AzIbHQXdMNcG1dKQswfJTQhO
 LNoEh5FYA6Oj6qWig2yNlykO8BZx0/6sTj+Hp6SwyoG9iLTs0BsNSkE+T7NYjpwhL7zP
 H3F4qI1LFsHfYC5WflH2O+UDBPMh9iEV0tWrC2qjQihZ1WwlM34ehUY4QxMD/cWeGmso Rg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3jtun083-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 15:22:47 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30HFMUXr020656;
        Tue, 17 Jan 2023 15:22:46 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n4rq3xknv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 15:22:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UpnB5qUMmWHImC7ekiRlLxcAnAV5Zx7GwKQunO9p8aLrMyMd107A0GSZkEOrKF1EchFNOBwCeeX7i0RIUEGTJVZhfpTE4hXyMk4ov88jWv8UNSu4nY1TUMOUPUm1AfLXF6Rawf+nCSED79DqLejZV/hC7qmjezfZDmoYR64ELdWuWQzRnVPeOUJYdEDLqegv8vZ2CCXZW9S/YV34znuFpogSTreeRlOVa42By8vJAmT7cHZclGEn6rGG66d/ai9MWOopYTbas7Y5twomPOlO9kmFxG3E+PY7MjhEmxqLU3whgB1HoEg6V2be5QoUfBc/B3ad2fepqsz7G15N4LRyOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7TTu95h8C7sBRXS8euCUb1uZyPb5NZcAWXH6Ol6pIwg=;
 b=XPHyXPTQx9PGudpaRYIYRauM+oApPvACaos2ZjwnxAPgTPfLGgeHRTJV8JrQkJSJ6wXrpXGuXhu3Uxr8UUlevJWQnSkK5BQXZYH48ZIOTLv6CxV+MEh03V37F3ZyaMmqCbnVLj/p8TIK9uJtsQuReytnL2N9EAHIAzERw7Bmkn4ym6wT2DSqObq+YlQ9kbSdAfogLoatWlWm+ss3un2RTfZDU5Tlf9YrckzYJY5F5vJEkHsNi8bB9Fr0VDhlY2RKtFoeBygEKe8xhGrgrSF+fTCAIGlM1L3E7wG4fXjKjGvonYOjjc6+ZNvJ4TIg8FmC4OGjqObWOwDEDiwX9VxUtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7TTu95h8C7sBRXS8euCUb1uZyPb5NZcAWXH6Ol6pIwg=;
 b=GvolBggh+kI9LN1gmobqk5yv6sTBRE1nZ/w4dCXJN77xUX2ZoW//VPc0IdHRzfJQyJpMx+G3WBSng1sG0YsZ3P/38Un8BtGnPO0eIt6LGn42MAX5cVlP7h0uUQXvVjso7MRIdxD1T+Vp5YQoPLmbcHYyp2iwAm/g4Xe2TbR6NL8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB4236.namprd10.prod.outlook.com (2603:10b6:5:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Tue, 17 Jan
 2023 15:22:42 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9%5]) with mapi id 15.20.6002.013; Tue, 17 Jan 2023
 15:22:42 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Jeff Layton <jlayton@kernel.org>,
        Yishai Hadas <yishaih@nvidia.com>,
        Shachar Kagan <skagan@nvidia.com>,
        Itay Aveksis <itayav@nvidia.com>, Neil Brown <neilb@suse.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v5 3/5] nfsd: rework refcounting in filecache
Thread-Topic: [PATCH v5 3/5] nfsd: rework refcounting in filecache
Thread-Index: AQHY7gDKf+UJMCSoA0e+WwOAy53hT66jMXqAgAABmIA=
Date:   Tue, 17 Jan 2023 15:22:42 +0000
Message-ID: <9CAD601F-C323-405F-840A-9CBAF520948B@oracle.com>
References: <20221101144647.136696-1-jlayton@kernel.org>
 <20221101144647.136696-4-jlayton@kernel.org> <Y8a766ypSbKbevTJ@nvidia.com>
In-Reply-To: <Y8a766ypSbKbevTJ@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DM6PR10MB4236:EE_
x-ms-office365-filtering-correlation-id: 8472c291-8473-465c-7b17-08daf89ead5e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6AqPtwgekIX+nUuA7tVCuTi+CuJMkFTHja7lMFnZIhYzzVOp80IyB1NuEnGzcau4AD4DurckM9liixbAjoG+NA0QcAp3CqROsTSTyMlMRB4MHXE2XsVnvjsBYTMas/hTNlGV6EQjE4ibDtFH3EowdnqQp4tUDgZmAruSS8DqQ9j0go8MoD8S/rt8TklCZMSmW0odHBUpFXS0np02FiLDBe02Ykd/FKecLswYGXQyS8i99RnmpQ/fPbdYC2tSEaoYLtPC0pIsAq2rGbREdhOOl3+26zSC5GW9oJleTvGhCk1fkQWwXyZEF6qPOznP1H7g4rYqp0ajwlYpLaPpYCTXqTiKCq7jQHUsqD17I+8nFI5F9Y5mIBd0wFvoji0HaLjOzwuPOOJ7owx6oCFmd2uHnnQEdKTUDUnUI86kI3b4Lsog32cOKo85vs9x2y8hIIZGaD3wqC1kD+WghsfSTEJxN1vaQeqyP3DV7kJdoFsvXZSqvkkHmJMmsK+JLe1HvkWAFBnFtfVP6FstFJ3QbspN3wsKyYqOEpK5oCH3DMjsgS8OwuvKTVdxXhNGcvT79mKk/jGHFGojuvXJKSDA18PO3dS67HsWJcUSoD4+rbzuXxttZrLalrmWRNU2lmxgHCmUgfQkncEEcclwpifn7ZnraDfljxuEjXz+4SALChRzymQh9csKwiQ7p/1HvAPum3CnYHYyOiH1yUIll+Xe9FxxT+CI19LFgNN/ypqge9eKtgk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(346002)(136003)(376002)(366004)(451199015)(83380400001)(66899015)(54906003)(6512007)(6486002)(45080400002)(71200400001)(36756003)(33656002)(478600001)(186003)(38100700002)(38070700005)(122000001)(2616005)(86362001)(41300700001)(2906002)(30864003)(53546011)(26005)(6506007)(66556008)(91956017)(66446008)(76116006)(6916009)(8936002)(8676002)(66476007)(64756008)(4326008)(66946007)(316002)(5660300002)(45980500001)(559001)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vUy9UkwuCIKUjjnA/xoLhUOEq754xt2e73/Sht0dfEOH+IDRI6cEualnbryx?=
 =?us-ascii?Q?dTyqsGrDPtRKlW9jL+8m3BMJtrsIa2FC7bHLN6ImiVre29SMvBc4r7CinXHu?=
 =?us-ascii?Q?plB8F6s/61AHPpBizWdWvTO6OY4tfYg3Qr1wGIjx1KrfbdTzBTNrnvU7U80a?=
 =?us-ascii?Q?KJbxDIr8Wu8I4mPHQLxs0Mjzmt+nQD1GhAmkWnr42YEKJiAv5nAW/7GPEKdv?=
 =?us-ascii?Q?FQRC5ujuW06A2gylMuqdiC2DxgXBt4c/fEbizfNaLkR2QAXPeu1iLkVN5+Ei?=
 =?us-ascii?Q?NF1OwKsB8iRpaYdQtXFG/nAZt+Cf7T3KbUDddWTraKfOfjVGOdgcdwH5+15n?=
 =?us-ascii?Q?paqjOd361m5I6jeVd/XLHkKxHOPfpTwFrlSK8tnjEMgGmxYrqDUTmAd4ZGhK?=
 =?us-ascii?Q?b1BEpw5qIm6Vvr70v3tPO/1NCTPtFon9S3HHEdxmvJbEHKmWmFBI8bdo7y2O?=
 =?us-ascii?Q?xtQm0YF8RRbBfgmwPHNMtLPzy73Cz6Kak/k6z/BUBGdpkc+VCW8WwXW3KjIv?=
 =?us-ascii?Q?5pZ1E81xgJUtb4kg07CGMofwUm5xpXntJZ/AsPuc4Ad7j7+PfMB5dx+IIu7r?=
 =?us-ascii?Q?E40kiOTf0g4ZWBvG+DFXR6YZ3hUYHnhRuZqvtDm6XIcQaD7fjMyDgayiCJIB?=
 =?us-ascii?Q?MgNqYMdiKd4CjXejoR87jypUrRAtukdn9hHQV5bpigeJ4aqLZXXzgJVd3b++?=
 =?us-ascii?Q?C42WfKXOxe677mVQ6YdMSmkyR7cJ8zROqFYrIQ4cwGfpX0+rP/P8TafQZdVE?=
 =?us-ascii?Q?ngGvhKw+b9qXYn47sb7NXARRlNnKYjvJ/HdI0ir0Q08rEuPCUb4+mhK3paM0?=
 =?us-ascii?Q?Py008xhV/wp7IHfQvsP99yrQXvkmxTz/Jy+K9W5ZDGh7hNOPxXwdPsCIpTom?=
 =?us-ascii?Q?Yrh99Pguv4R3D2Be6ItJIGNN4gsqOHvbHSwV+5XgBxfxdAnnNXUmUkPat8yo?=
 =?us-ascii?Q?ZOYTXxcQf3/O7XWKOGCD76CBZv+YLG0tMVMw7CQWjPVfL83WxbRfhwrnsfD4?=
 =?us-ascii?Q?4bC2OxZChI+iFYWFq8iK34oLm47UJWZ/b+qUBZcH2f17V7M7AwIAK6bFZ4nX?=
 =?us-ascii?Q?5sKHf7PGE+U9u+4tv/9nnLI7o9XvUIORDp378D1rn2VhH3yASWRVXVVgFVa3?=
 =?us-ascii?Q?+HMHMPP2tCbh7hn0otwKAnYbLvPn8jjLmsewjIN3jt/sEjWC1EnwWvNh3Znb?=
 =?us-ascii?Q?hPxAxEWsSRZphkc6A8yFgFisJAAdrfaMfCfWd16dWcQFbs79f1v/bpU8WUIs?=
 =?us-ascii?Q?mc+XG90xStoavtRjR1D/7EQQM7XnBvujUzcxb6hjRdEd7nQRb/cvdjGeRWdg?=
 =?us-ascii?Q?gvWV6yARkKMDMmr7vZ+CblRHQfi6hE1wobW+OH5GwasSVsG3c4wac1eae4WE?=
 =?us-ascii?Q?G7AZdz4wUzqHljvEpZplvnqNtK33dKEALCFUzFtQnVx9xGCPEwle93NDOMHo?=
 =?us-ascii?Q?Zle49udBGrlpmRTOWn8lr+7VBzZryu1H0CYj3T2gzP2kJ349ItMJSGAvS9Ij?=
 =?us-ascii?Q?ntONFW3E42X3xBz5dhGPHXL8GCSnGbldRIknkSiP4OL4T6LLkSjcL5akKYaW?=
 =?us-ascii?Q?5dXGGkXssQA8Jj+/BCsAmn/7SfpeDkRfNGafd/wmho8hWKyhvYnDFi3S4b8w?=
 =?us-ascii?Q?fQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B26995C90DB9D54E96423BDF6FCEBD87@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8bdmci1iyChqwoX3eAQI9F0gMl8O0SpQ1OoyKRZ7OdawyWTByySKBWy8qM7awdkf8vyiKyzsQ/lYdXEv8UAi7GBRcOYE4yWHApndg8iv5w68yu97AvvvEM4ADnod254CTBWRB9tMrix+IHSk5SMx4NtnFUIxNzW5gnARh/wv04nIVlHz+z0v3IZ7SnpCMUd64yPsu1qxbjEBDd0HUyBj6u4esZzPgVkMMu2GZ5tsoD/E3Kmcl0j+gsRF6omgM+yurStkFmmvNragWTZaGFWGbrmtzf4stX3gRPEKGgM+7QNCSJ5JSMcg9aVI7K8/gyf6jxrCdsOv98PJlyYbTdESjZi18rMPhJTAYtJqd0NpIKoXAy+eJQZb2x1hNj+G9kY7xTLoVqOtNHgETZ7Eg48/XfQLmQDZ/UAgJpilH9dVmhuEXtCCqgdZDE2B/A3H+RSIWnXH70HGPiHimQDIBWnQ7xfgrS5SAINjAvFc6Ai5wPbaM6XlnfQPIOoZd8jZTss+VrrFEKZnQyNqWgCyOFqS03Hy13Z830E8wkC7bkSI4PH+06QiNrZEsvkoOH0GLCpRYmZNGWPxpW46YfyER4z4OTce5ppoT51VL06ezmPAmdo3N3T2jxM0Y3pYJ2K89nTvBQ80IlN0krRhLaRHYKCElmnZvftugZTgYwHNSuE3BfDhsjAoyTYKCSHckhKvkJQxJ6/Mc+MBsXOPEi5IkqOFEDwLG8Czphhw6e4NOZT3nqEAKkDch2yfGs1Fnp89sfhHz2cYDVdlDzvF2SpsfKcjlgmGCtLLCJRHYF9dDcqCCACZc8n2qlN+Vpvy8RYAm/QrcLAQxqTZZS3yyehdrooC9Q==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8472c291-8473-465c-7b17-08daf89ead5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 15:22:42.3205
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VEpahz2vXk6qXOJsyxqiK1sh0LixSJJZFYqQwP7OIuSg5UaEwO4HGL8Ik3Rx19+Jj3GQiFOproUYQ3ArgBy4ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4236
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-17_06,2023-01-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301170123
X-Proofpoint-GUID: al21ynr7zZeBd6f6VpqKzHANyxPgxxaU
X-Proofpoint-ORIG-GUID: al21ynr7zZeBd6f6VpqKzHANyxPgxxaU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 17, 2023, at 10:16 AM, Jason Gunthorpe <jgg@nvidia.com> wrote:
>=20
> On Tue, Nov 01, 2022 at 10:46:45AM -0400, Jeff Layton wrote:
>> The filecache refcounting is a bit non-standard for something searchable
>> by RCU, in that we maintain a sentinel reference while it's hashed. This
>> in turn requires that we have to do things differently in the "put"
>> depending on whether its hashed, which we believe to have led to races.
>>=20
>> There are other problems in here too. nfsd_file_close_inode_sync can end
>> up freeing an nfsd_file while there are still outstanding references to
>> it, and there are a number of subtle ToC/ToU races.
>>=20
>> Rework the code so that the refcount is what drives the lifecycle. When
>> the refcount goes to zero, then unhash and rcu free the object.
>>=20
>> With this change, the LRU carries a reference. Take special care to
>> deal with it when removing an entry from the list.
>>=20
>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>=20
> Our test team is getting crashes that bisection pointed at this
> patch. It seems like there are multiple parallel crash reports so the
> whole thing is a mess to read:
>=20
> [  875.548965] BUG: kernel NULL pointer dereference, address: 00000000000=
000d0
> [  875.548968] ------------[ cut here ]------------
> [  875.548972] refcount_t: underflow; use-after-free.
> [  875.548992] WARNING: CPU: 4 PID: 12145 at lib/refcount.c:28 refcount_w=
arn_saturate+0xd8/0xe0
> [  875.549851] #PF: supervisor read access in kernel mode
> [  875.550158] Modules linked in:
> [  875.550752] #PF: error_code(0x0000) - not-present page
> [  875.551269]  nfsd
> [  875.551878] PGD 0
> [  875.552069]  iptable_raw
> [  875.552677] P4D 0
> [  875.552824]  bonding mlx5_vfio_pci
> [  875.553095]
> [  875.553255]  rdma_ucm ipip
> [  875.553525] Oops: 0000 [#1] SMP
> [  875.553733]  tunnel4
> [  875.553941] CPU: 0 PID: 12147 Comm: nfsd Not tainted 6.1.0-rc7_ac3a258=
5f018 #1
> [  875.554109]  ip_gre ib_umad
> [  875.554517] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS r=
el-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> [  875.554656]  nf_tables vfio_pci
> [  875.555508] RIP: 0010:vfs_setlease+0x27/0x70
> [  875.555695]  vfio_pci_core vfio_virqfd
> [  875.557015] Code: ff ff 90 0f 1f 44 00 00 41 54 49 89 d4 55 48 89 fd 4=
8 83 ec 10 48 85 d2 74 06 48 83 fe 02 75 1f 48 8b 45 28 4c 89 e2 48 89 ef <=
48> 8b 80 d0 00 00 00 48 85 c0 74 2c 48 83 c4 10 5d 41 5c ff e0 48
> [  875.557209]  vfio_iommu_type1
> [  875.557406] RSP: 0018:ffff88810378bdb0 EFLAGS: 00010246
> [  875.557634]  mlx5_ib
> [  875.558446]
> [  875.558628]  vfio
> [  875.558862] RAX: 0000000000000000 RBX: ffff88824866c000 RCX: ffff88810=
378bdd8
> [  875.559006]  ib_uverbs
> [  875.559092] RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffff88812=
560a200
> [  875.559218]  ib_ipoib
> [  875.559557] RBP: ffff88812560a200 R08: ffff8881da5ecf00 R09: ffffffff8=
24064e0
> [  875.559704]  mlx5_core
> [  875.560021] R10: 0000000000000000 R11: 0000000000000000 R12: 000000000=
0000000
> [  875.560165]  ip6_gre
> [  875.560488] R13: ffff8881da5ecf00 R14: ffff888110e62028 R15: ffff88811=
0e621a0
> [  875.560634]  gre
> [  875.560959] FS:  0000000000000000(0000) GS:ffff88852c800000(0000) knlG=
S:0000000000000000
> [  875.561108]  ip6_tunnel
> [  875.561432] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  875.561554]  tunnel6
> [  875.561928] CR2: 00000000000000d0 CR3: 00000001ca27d001 CR4: 000000000=
0372eb0
> [  875.562084]  geneve
> [  875.562349] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [  875.562493]  nfnetlink_cttimeout
> [  875.562822] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [  875.562962]  openvswitch
> [  875.563292] Call Trace:
> [  875.563298]  <TASK>
> [  875.563503]  nsh
> [  875.563839]  destroy_unhashed_deleg+0x58/0xc0 [nfsd]

We are aware of this failure mode. Actually this started well before
that particular commit.

Our problem has been that no one has been able to provide a reliable
reproducer, so we can't figure out why it's happening. If you have a
way to reproduce this failure reliably, can you capture a vmcore or
enable KASAN and get a little more information?


> [  875.563997]  vhost_net
> [  875.564124]  nfsd4_delegreturn+0x119/0x150 [nfsd]
> [  875.564262]  vhost
> [  875.564357]  nfsd4_proc_compound+0x282/0x5d0 [nfsd]
> [  875.564661]  vhost_iotlb
> [  875.564798]  nfsd_dispatch+0x15d/0x250 [nfsd]
> [  875.565084]  tap
> [  875.565187]  svc_process_common+0x2b6/0x4d0
> [  875.565483]  ip6table_mangle
> [  875.565607]  ? nfsd_svc+0x330/0x330 [nfsd]
> [  875.565878]  ip6table_nat
> [  875.565972]  ? nfsd_shutdown_threads+0x90/0x90 [nfsd]
> [  875.566228]  iptable_mangle
> [  875.566371]  svc_process+0xd4/0xf0
> [  875.566622]  ip6table_filter
> [  875.566748]  nfsd+0xcb/0x180 [nfsd]
> [  875.567063]  ip6_tables
> [  875.567194]  kthread+0xb9/0xe0
> [  875.567412]  xt_conntrack
> [  875.567557]  ? kthread_complete_and_exit+0x20/0x20
> [  875.567776]  xt_MASQUERADE
> [  875.567892]  ret_from_fork+0x1f/0x30
> [  875.568084]  nf_conntrack_netlink
> [  875.568212]  </TASK>
> [  875.568500]  nfnetlink
> [  875.568631] Modules linked in:
> [  875.568853]  xt_addrtype
> [  875.569025]  nfsd
> [  875.569167]  iptable_nat
> [  875.569270]  iptable_raw
> [  875.569464]  nf_nat
> [  875.569572]  bonding
> [  875.569701]  br_netfilter
> [  875.569810]  mlx5_vfio_pci
> [  875.569971]  overlay
> [  875.570064]  rdma_ucm
> [  875.570211]  rpcrdma
> [  875.570317]  ipip tunnel4 ip_gre ib_umad nf_tables vfio_pci vfio_pci_c=
ore vfio_virqfd vfio_iommu_type1 mlx5_ib vfio ib_uverbs
> [  875.570492]  ib_iser
> [  875.570590]  ib_ipoib
> [  875.570737]  libiscsi
> [  875.570834]  mlx5_core
> [  875.571499]  scsi_transport_iscsi
> [  875.571592]  ip6_gre
> [  875.571736]  rdma_cm
> [  875.571835]  gre
> [  875.571984]  iw_cm
> [  875.572126]  ip6_tunnel
> [  875.572272]  ib_cm
> [  875.572366]  tunnel6
> [  875.572489]  ib_core
> [  875.572581]  geneve
> [  875.572738]  fuse
> [  875.572834]  nfnetlink_cttimeout
> [  875.572978]  [last unloaded: nf_tables]
> [  875.573076]  openvswitch
> [  875.573214]
> [  875.573299]  nsh
> [  875.573503] CPU: 4 PID: 12145 Comm: nfsd Not tainted 6.1.0-rc7_ac3a258=
5f018 #1
> [  875.573666]  vhost_net
> [  875.573826] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS r=
el-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> [  875.573898]  vhost
> [  875.574022] RIP: 0010:refcount_warn_saturate+0xd8/0xe0
> [  875.574318]  vhost_iotlb
> [  875.574469] Code: ff 48 c7 c7 70 60 26 82 c6 05 d7 aa fb 00 01 e8 35 3=
c 4a 00 0f 0b c3 48 c7 c7 18 60 26 82 c6 05 c3 aa fb 00 01 e8 1f 3c 4a 00 <=
0f> 0b c3 0f 1f 44 00 00 8b 07 3d 00 00 00 c0 74 12 83 f8 01 74 13
> [  875.574913]  tap
> [  875.575056] RSP: 0018:ffff88811d127db0 EFLAGS: 00010282
> [  875.575265]  ip6table_mangle
> [  875.575426]
> [  875.576149]  ip6table_nat
> [  875.576274] RAX: 0000000000000000 RBX: ffff88810669f138 RCX: ffff88852=
ca1b548
> [  875.576486]  iptable_mangle
> [  875.576669] RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffff88852=
ca1b540
> [  875.576740]  ip6table_filter
> [  875.576915] RBP: ffff8881028410f0 R08: 80000000fffff3b3 R09: ffff88811=
d127d48
> [  875.577203]  ip6_tables
> [  875.577379] R10: 0000000000000b16 R11: 0000000000000001 R12: 000000000=
0000000
> [  875.577663]  xt_conntrack
> [  875.577846] R13: ffff8881dd380e00 R14: ffff888110e5a028 R15: ffff88811=
0e5a1a0
> [  875.578136]  xt_MASQUERADE
> [  875.578294] FS:  0000000000000000(0000) GS:ffff88852ca00000(0000) knlG=
S:0000000000000000
> [  875.578579]  nf_conntrack_netlink
> [  875.578754] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  875.579040]  nfnetlink xt_addrtype iptable_nat nf_nat br_netfilter ove=
rlay rpcrdma ib_iser libiscsi scsi_transport_iscsi rdma_cm iw_cm
> [  875.579218] CR2: 00007fd8ec0017a8 CR3: 000000016a0db004 CR4: 000000000=
0372ea0
> [  875.579538]  ib_cm
> [  875.579745] Call Trace:
> [  875.579977]  ib_core
> [  875.580688]  <TASK>
> [  875.580983]  fuse
> [  875.581118]  nfsd_file_free+0x1c4/0x200 [nfsd]
> [  875.581222]  [last unloaded: nf_tables]
> [  875.581366]  destroy_unhashed_deleg+0xac/0xc0 [nfsd]
> [  875.581457]
> [  875.581586]  nfsd4_delegreturn+0x119/0x150 [nfsd]
> [  875.581775] CR2: 00000000000000d0
> [  875.582012]  nfsd4_proc_compound+0x282/0x5d0 [nfsd]
> [  875.582216] ---[ end trace 0000000000000000 ]---
> [  875.582217] BUG: kernel NULL pointer dereference, address: 00000000000=
000d0
> [  875.582219] #PF: supervisor read access in kernel mode
> [  875.582220] #PF: error_code(0x0000) - not-present page
> [  875.582222] PGD 0 P4D 0
> [  875.582228] Oops: 0000 [#2] SMP
> [  875.582229] CPU: 8 PID: 12143 Comm: nfsd Tainted: G      D            =
6.1.0-rc7_ac3a2585f018 #1
> [  875.582231] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS r=
el-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> [  875.582232] RIP: 0010:vfs_setlease+0x27/0x70
> [  875.582236] Code: ff ff 90 0f 1f 44 00 00 41 54 49 89 d4 55 48 89 fd 4=
8 83 ec 10 48 85 d2 74 06 48 83 fe 02 75 1f 48 8b 45 28 4c 89 e2 48 89 ef <=
48> 8b 80 d0 00 00 00 48 85 c0 74 2c 48 83 c4 10 5d 41 5c ff e0 48
> [  875.582238] RSP: 0018:ffff888119c97db0 EFLAGS: 00010246
> [  875.582239] RAX: 0000000000000000 RBX: ffff88824866c690 RCX: ffff88811=
9c97dd8
> [  875.582241] RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffff88812=
560b200
> [  875.582242] RBP: ffff88812560b200 R08: ffff8881dd381800 R09: ffffffff8=
2407758
> [  875.582243] R10: 0000000000000000 R11: 0000000000000000 R12: 000000000=
0000000
> [  875.582244] R13: ffff8881dd381800 R14: ffff8881010cc028 R15: ffff88810=
10cc1a0
> [  875.582245] FS:  0000000000000000(0000) GS:ffff88852cc00000(0000) knlG=
S:0000000000000000
> [  875.582247] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  875.582248] CR2: 00000000000000d0 CR3: 000000011c26d004 CR4: 000000000=
0372ea0
> [  875.582250] Call Trace:
> [  875.582251]  <TASK>
> [  875.582253]  destroy_unhashed_deleg+0x58/0xc0 [nfsd]
> [  875.582268]  nfsd4_delegreturn+0x119/0x150 [nfsd]
> [  875.582280]  nfsd4_proc_compound+0x282/0x5d0 [nfsd]
> [  875.582292]  nfsd_dispatch+0x15d/0x250 [nfsd]
> [  875.582302]  svc_process_common+0x2b6/0x4d0
> [  875.582305]  ? nfsd_svc+0x330/0x330 [nfsd]
> [  875.582315]  ? nfsd_shutdown_threads+0x90/0x90 [nfsd]
> [  875.582323]  nfsd_dispatch+0x15d/0x250 [nfsd]
> [  875.582339]  svc_process_common+0x2b6/0x4d0
> [  875.582343]  ? nfsd_svc+0x330/0x330 [nfsd]
> [  875.582357]  ? nfsd_shutdown_threads+0x90/0x90 [nfsd]
> [  875.582371]  svc_process+0xd4/0xf0
> [  875.582374]  nfsd+0xcb/0x180 [nfsd]
> [  875.582388]  kthread+0xb9/0xe0
> [  875.582392]  ? kthread_complete_and_exit+0x20/0x20
> [  875.582398]  ret_from_fork+0x1f/0x30
> [  875.582401]  </TASK>
> [  875.582402] ---[ end trace 0000000000000000 ]---
> [  875.582518] RIP: 0010:vfs_setlease+0x27/0x70
> [  875.582673]  svc_process+0xd4/0xf0
> [  875.582873] Code: ff ff 90 0f 1f 44 00 00 41 54 49 89 d4 55 48 89 fd 4=
8 83 ec 10 48 85 d2 74 06 48 83 fe 02 75 1f 48 8b 45 28 4c 89 e2 48 89 ef <=
48> 8b 80 d0 00 00 00 48 85 c0 74 2c 48 83 c4 10 5d 41 5c ff e0 48
> [  875.583075]  nfsd+0xcb/0x180 [nfsd]
> [  875.583350] RSP: 0018:ffff88810378bdb0 EFLAGS: 00010246
> [  875.583559]  kthread+0xb9/0xe0
> [  875.583767]
> [  875.583878]  ? kthread_complete_and_exit+0x20/0x20
> [  875.584013] RAX: 0000000000000000 RBX: ffff88824866c000 RCX: ffff88810=
378bdd8
> [  875.584363]  ret_from_fork+0x1f/0x30
> [  875.584810] RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffff88812=
560a200
> [  875.584990]  </TASK>
> [  875.585722] RBP: ffff88812560a200 R08: ffff8881da5ecf00 R09: ffffffff8=
24064e0
> [  875.585936] Modules linked in:
> [  875.586219] R10: 0000000000000000 R11: 0000000000000000 R12: 000000000=
0000000
> [  875.586507]  nfsd
> [  875.586793] R13: ffff8881da5ecf00 R14: ffff888110e62028 R15: ffff88811=
0e621a0
> [  875.587094]  iptable_raw
> [  875.587383] FS:  0000000000000000(0000) GS:ffff88852c800000(0000) knlG=
S:0000000000000000
> [  875.587703]  bonding
> [  875.587935] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  875.588223]  mlx5_vfio_pci
> [  875.588331] CR2: 00000000000000d0 CR3: 00000001ca27d001 CR4: 000000000=
0372eb0
> [  875.588426]  rdma_ucm
> [  875.588631] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [  875.588835]  ipip
> [  875.589035] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [  875.589215]  tunnel4 ip_gre ib_umad nf_tables vfio_pci vfio_pci_core v=
fio_virqfd vfio_iommu_type1 mlx5_ib vfio ib_uverbs ib_ipoib mlx5_core ip6_g=
re gre ip6_tunnel tunnel6 geneve nfnetlink_cttimeout openvswitch nsh vhost_=
net vhost vhost_iotlb tap ip6table_mangle ip6table_nat iptable_mangle ip6ta=
ble_filter ip6_tables xt_conntrack xt_MASQUERADE nf_conntrack_netlink nfnet=
link xt_addrtype iptable_nat nf_nat br_netfilter overlay rpcrdma ib_iser li=
biscsi scsi_transport_iscsi rdma_cm iw_cm ib_cm ib_core fuse [last unloaded=
: nf_tables]
> [  875.650660] CR2: 00000000000000d0
> [  875.650952] ---[ end trace 0000000000000000 ]---
> [  875.650952] BUG: unable to handle page fault for address: 000000012547=
108f
> [  875.651147] RIP: 0010:vfs_setlease+0x27/0x70
> [  875.651493] #PF: supervisor read access in kernel mode
> [  875.651670] Code: ff ff 90 0f 1f 44 00 00 41 54 49 89 d4 55 48 89 fd 4=
8 83 ec 10 48 85 d2 74 06 48 83 fe 02 75 1f 48 8b 45 28 4c 89 e2 48 89 ef <=
48> 8b 80 d0 00 00 00 48 85 c0 74 2c 48 83 c4 10 5d 41 5c ff e0 48
> [  875.651920] #PF: error_code(0x0000) - not-present page
> [  875.652644] RSP: 0018:ffff88810378bdb0 EFLAGS: 00010246
> [  875.652902] PGD 0
> [  875.653070]
> [  875.653329] P4D 0
> [  875.653418] RAX: 0000000000000000 RBX: ffff88824866c000 RCX: ffff88810=
378bdd8
> [  875.653501]
> [  875.653593] RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffff88812=
560a200
> [  875.653944] Oops: 0000 [#3] SMP
> [  875.654013] RBP: ffff88812560a200 R08: ffff8881da5ecf00 R09: ffffffff8=
24064e0
> [  875.654359] CPU: 7 PID: 12140 Comm: nfsd Tainted: G      D W          =
6.1.0-rc7_ac3a2585f018 #1
> [  875.654491] R10: 0000000000000000 R11: 0000000000000000 R12: 000000000=
0000000
> [  875.654837] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS r=
el-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> [  875.655184] R13: ffff8881da5ecf00 R14: ffff888110e62028 R15: ffff88811=
0e621a0
> [  875.655529] RIP: 0010:vfs_setlease+0x1d/0x70
> [  875.655970] FS:  0000000000000000(0000) GS:ffff88852cc00000(0000) knlG=
S:0000000000000000
> [  875.656318] Code: 19 37 76 00 49 89 ee e9 ac fc ff ff 90 0f 1f 44 00 0=
0 41 54 49 89 d4 55 48 89 fd 48 83 ec 10 48 85 d2 74 06 48 83 fe 02 75 1f <=
48> 8b 45 28 4c 89 e2 48 89 ef 48 8b 80 d0 00 00 00 48 85 c0 74 2c
> [  875.656497] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  875.656889] RSP: 0018:ffff88824874bdb0 EFLAGS: 00010246
> [  875.657608] CR2: 00000000000000d0 CR3: 000000011c26d004 CR4: 000000000=
0372ea0
> [  875.657899]
> [  875.665061] RAX: ffff8881807150d0 RBX: ffff8881034da230 RCX: ffff88824=
874bdd8
> [  875.665670] RDX: 0000000000000000 RSI: 0000000000000002 RDI: 000000012=
5471067
> [  875.666275] RBP: 0000000125471067 R08: ffff888248d72500 R09: ffffffff8=
2407758
> [  875.666886] R10: 0000000000000000 R11: 0000000000000000 R12: 000000000=
0000000
> [  875.667495] R13: ffff888248d72500 R14: ffff888103348028 R15: ffff88810=
33481a0
> [  875.668102] FS:  0000000000000000(0000) GS:ffff88852cb80000(0000) knlG=
S:0000000000000000
> [  875.668839] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  875.669347] CR2: 000000012547108f CR3: 00000001805ff002 CR4: 000000000=
0372ea0
> [  875.669950] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [  875.670550] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [  875.671160] Call Trace:
> [  875.671452]  <TASK>
> [  875.671724]  destroy_unhashed_deleg+0x58/0xc0 [nfsd]
> [  875.672197]  nfsd4_delegreturn+0x119/0x150 [nfsd]
> [  875.672658]  nfsd4_proc_compound+0x282/0x5d0 [nfsd]
> [  875.673139]  nfsd_dispatch+0x15d/0x250 [nfsd]
> [  875.673571]  svc_process_common+0x2b6/0x4d0
> [  875.673980]  ? nfsd_svc+0x330/0x330 [nfsd]
> [  875.674397]  ? nfsd_shutdown_threads+0x90/0x90 [nfsd]
> [  875.674877]  svc_process+0xd4/0xf0
> [  875.675237]  nfsd+0xcb/0x180 [nfsd]
> [  875.675606]  kthread+0xb9/0xe0
> [  875.675942]  ? kthread_complete_and_exit+0x20/0x20
> [  875.676394]  ret_from_fork+0x1f/0x30
> [  875.676769]  </TASK>
> [  875.677044] Modules linked in: nfsd iptable_raw bonding mlx5_vfio_pci =
rdma_ucm ipip tunnel4 ip_gre ib_umad nf_tables vfio_pci vfio_pci_core vfio_=
virqfd vfio_iommu_type1 mlx5_ib vfio ib_uverbs ib_ipoib mlx5_core ip6_gre g=
re ip6_tunnel tunnel6 geneve nfnetlink_cttimeout openvswitch nsh vhost_net =
vhost vhost_iotlb tap ip6table_mangle ip6table_nat iptable_mangle ip6table_=
filter ip6_tables xt_conntrack xt_MASQUERADE nf_conntrack_netlink nfnetlink=
 xt_addrtype iptable_nat nf_nat br_netfilter overlay rpcrdma ib_iser libisc=
si scsi_transport_iscsi rdma_cm iw_cm ib_cm ib_core fuse [last unloaded: nf=
_tables]
> [  875.681102] CR2: 000000012547108f
> [  875.681459] ---[ end trace 0000000000000000 ]---
> [  875.681460] BUG: kernel NULL pointer dereference, address: 00000000000=
000d0
> [  875.681689] RIP: 0010:vfs_setlease+0x27/0x70
> [  875.682042] #PF: supervisor read access in kernel mode
> [  875.682259] Code: ff ff 90 0f 1f 44 00 00 41 54 49 89 d4 55 48 89 fd 4=
8 83 ec 10 48 85 d2 74 06 48 83 fe 02 75 1f 48 8b 45 28 4c 89 e2 48 89 ef <=
48> 8b 80 d0 00 00 00 48 85 c0 74 2c 48 83 c4 10 5d 41 5c ff e0 48
> [  875.682517] #PF: error_code(0x0000) - not-present page
> [  875.683402] RSP: 0018:ffff88810378bdb0 EFLAGS: 00010246
> [  875.683656] PGD 0
> [  875.683865]
> [  875.684122] P4D 0
> [  875.684233] RAX: 0000000000000000 RBX: ffff88824866c000 RCX: ffff88810=
378bdd8
> [  875.684321]
> [  875.684430] RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffff88812=
560a200
> [  875.684787] Oops: 0000 [#4] SMP
> [  875.684874] RBP: ffff88812560a200 R08: ffff8881da5ecf00 R09: ffffffff8=
24064e0
> [  875.685226] CPU: 3 PID: 12146 Comm: nfsd Tainted: G      D W          =
6.1.0-rc7_ac3a2585f018 #1
> [  875.685397] R10: 0000000000000000 R11: 0000000000000000 R12: 000000000=
0000000
> [  875.685748] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS r=
el-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> [  875.686175] R13: ffff8881da5ecf00 R14: ffff888110e62028 R15: ffff88811=
0e621a0
> [  875.686525] RIP: 0010:vfs_setlease+0x27/0x70
> [  875.687063] FS:  0000000000000000(0000) GS:ffff88852cb80000(0000) knlG=
S:0000000000000000
> [  875.687412] Code: ff ff 90 0f 1f 44 00 00 41 54 49 89 d4 55 48 89 fd 4=
8 83 ec 10 48 85 d2 74 06 48 83 fe 02 75 1f 48 8b 45 28 4c 89 e2 48 89 ef <=
48> 8b 80 d0 00 00 00 48 85 c0 74 2c 48 83 c4 10 5d 41 5c ff e0 48
> [  875.687629] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  875.688023] RSP: 0018:ffff88811b81fdb0 EFLAGS: 00010246
> [  875.688915] CR2: 000000012547108f CR3: 00000001805ff002 CR4: 000000000=
0372ea0
> [  875.689200]
> [  875.689462] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [  875.689809] RAX: 0000000000000000 RBX: ffff88824866c230 RCX: ffff88811=
b81fdd8
> [  875.689896] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [  875.690242] RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffff88812=
560ad00
> [  875.698805] RBP: ffff88812560ad00 R08: ffff8881dd381b00 R09: ffffffff8=
2407740
> [  875.699422] R10: 0000000000000000 R11: 0000000000000000 R12: 000000000=
0000000
> [  875.700031] R13: ffff8881dd381b00 R14: ffff888110e5e028 R15: ffff88811=
0e5e1a0
> [  875.700643] FS:  0000000000000000(0000) GS:ffff88852c980000(0000) knlG=
S:0000000000000000
> [  875.701384] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  875.701892] CR2: 00000000000000d0 CR3: 0000000180622003 CR4: 000000000=
0372ea0
> [  875.702501] Call Trace:
> [  875.702797]  <TASK>
> [  875.703065]  destroy_unhashed_deleg+0x58/0xc0 [nfsd]
> [  875.703536]  nfsd4_delegreturn+0x119/0x150 [nfsd]
> [  875.703992]  nfsd4_proc_compound+0x282/0x5d0 [nfsd]
> [  875.704463]  nfsd_dispatch+0x15d/0x250 [nfsd]
> [  875.704897]  svc_process_common+0x2b6/0x4d0
> [  875.705305]  ? nfsd_svc+0x330/0x330 [nfsd]
> [  875.705717]  ? nfsd_shutdown_threads+0x90/0x90 [nfsd]
> [  875.706194]  svc_process+0xd4/0xf0
> [  875.706549]  nfsd+0xcb/0x180 [nfsd]
> [  875.706919]  kthread+0xb9/0xe0
> [  875.707257]  ? kthread_complete_and_exit+0x20/0x20
> [  875.707706]  ret_from_fork+0x1f/0x30
> [  875.708073]  </TASK>
> [  875.708348] Modules linked in: nfsd iptable_raw bonding mlx5_vfio_pci =
rdma_ucm ipip tunnel4 ip_gre ib_umad nf_tables vfio_pci vfio_pci_core vfio_=
virqfd vfio_iommu_type1 mlx5_ib vfio ib_uverbs ib_ipoib mlx5_core ip6_gre g=
re ip6_tunnel tunnel6 geneve nfnetlink_cttimeout openvswitch nsh vhost_net =
vhost vhost_iotlb tap ip6table_mangle ip6table_nat iptable_mangle ip6table_=
filter ip6_tables xt_conntrack xt_MASQUERADE nf_conntrack_netlink nfnetlink=
 xt_addrtype iptable_nat nf_nat br_netfilter overlay rpcrdma ib_iser libisc=
si scsi_transport_iscsi rdma_cm iw_cm ib_cm ib_core fuse [last unloaded: nf=
_tables]
> [  875.721375] CR2: 00000000000000d0
> [  875.721738] ---[ end trace 0000000000000000 ]---
> [  875.721738] BUG: kernel NULL pointer dereference, address: 00000000000=
00028
> [  875.721972] RIP: 0010:vfs_setlease+0x27/0x70
> [  875.722317] #PF: supervisor read access in kernel mode
> [  875.722530] Code: ff ff 90 0f 1f 44 00 00 41 54 49 89 d4 55 48 89 fd 4=
8 83 ec 10 48 85 d2 74 06 48 83 fe 02 75 1f 48 8b 45 28 4c 89 e2 48 89 ef <=
48> 8b 80 d0 00 00 00 48 85 c0 74 2c 48 83 c4 10 5d 41 5c ff e0 48
> [  875.722782] #PF: error_code(0x0000) - not-present page
> [  875.723675] RSP: 0018:ffff88810378bdb0 EFLAGS: 00010246
> [  875.723929] PGD 0
> [  875.724135]
> [  875.724393] P4D 0
> [  875.724499] RAX: 0000000000000000 RBX: ffff88824866c000 RCX: ffff88810=
378bdd8
> [  875.724584]
> [  875.724695] RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffff88812=
560a200
> [  875.725055] Oops: 0000 [#5] SMP
> [  875.725140] RBP: ffff88812560a200 R08: ffff8881da5ecf00 R09: ffffffff8=
24064e0
> [  875.725485] CPU: 2 PID: 12142 Comm: nfsd Tainted: G      D W          =
6.1.0-rc7_ac3a2585f018 #1
> [  875.725647] R10: 0000000000000000 R11: 0000000000000000 R12: 000000000=
0000000
> [  875.725992] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS r=
el-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> [  875.726411] R13: ffff8881da5ecf00 R14: ffff888110e62028 R15: ffff88811=
0e621a0
> [  875.726755] RIP: 0010:vfs_setlease+0x1d/0x70
> [  875.727285] FS:  0000000000000000(0000) GS:ffff88852c980000(0000) knlG=
S:0000000000000000
> [  875.727631] Code: 19 37 76 00 49 89 ee e9 ac fc ff ff 90 0f 1f 44 00 0=
0 41 54 49 89 d4 55 48 89 fd 48 83 ec 10 48 85 d2 74 06 48 83 fe 02 75 1f <=
48> 8b 45 28 4c 89 e2 48 89 ef 48 8b 80 d0 00 00 00 48 85 c0 74 2c
> [  875.727843] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  875.728225] RSP: 0018:ffff88811b813db0 EFLAGS: 00010246
> [  875.729115] CR2: 00000000000000d0 CR3: 0000000180622003 CR4: 000000000=
0372ea0
> [  875.729396]
> [  875.735502] RAX: ffff888180715000 RBX: ffff8881034da000 RCX: ffff88811=
b813dd8
> [  875.736015] RDX: 0000000000000000 RSI: 0000000000000002 RDI: 000000000=
0000000
> [  875.736531] RBP: 0000000000000000 R08: ffff888248d73200 R09: ffffffff8=
24065b8
> [  875.737043] R10: 0000000000000000 R11: 0000000000000000 R12: 000000000=
0000000
> [  875.737560] R13: ffff888248d73200 R14: ffff88824501c028 R15: ffff88824=
501c1a0
> [  875.738063] FS:  0000000000000000(0000) GS:ffff88852c900000(0000) knlG=
S:0000000000000000
> [  875.738678] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  875.739118] CR2: 0000000000000028 CR3: 0000000105b6e003 CR4: 000000000=
0372ea0
> [  875.739636] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [  875.740138] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [  875.740658] Call Trace:
> [  875.740907]  <TASK>
> [  875.741135]  destroy_unhashed_deleg+0x58/0xc0 [nfsd]
> [  875.741558]  nfsd4_delegreturn+0x119/0x150 [nfsd]
> [  875.741941]  nfsd4_proc_compound+0x282/0x5d0 [nfsd]
> [  875.742334]  nfsd_dispatch+0x15d/0x250 [nfsd]
> [  875.742711]  svc_process_common+0x2b6/0x4d0
> [  875.743064]  ? nfsd_svc+0x330/0x330 [nfsd]
> [  875.743406]  ? nfsd_shutdown_threads+0x90/0x90 [nfsd]
> [  875.743816]  svc_process+0xd4/0xf0
> [  875.744121]  nfsd+0xcb/0x180 [nfsd]
> [  875.744437]  kthread+0xb9/0xe0
> [  875.744733]  ? kthread_complete_and_exit+0x20/0x20
> [  875.745123]  ret_from_fork+0x1f/0x30
> [  875.745434]  </TASK>
> [  875.745663] Modules linked in: nfsd iptable_raw bonding mlx5_vfio_pci =
rdma_ucm ipip tunnel4 ip_gre ib_umad nf_tables vfio_pci vfio_pci_core vfio_=
virqfd vfio_iommu_type1 mlx5_ib vfio ib_uverbs ib_ipoib mlx5_core ip6_gre g=
re ip6_tunnel tunnel6 geneve nfnetlink_cttimeout openvswitch nsh vhost_net =
vhost vhost_iotlb tap ip6table_mangle ip6table_nat iptable_mangle ip6table_=
filter ip6_tables xt_conntrack xt_MASQUERADE nf_conntrack_netlink nfnetlink=
 xt_addrtype iptable_nat nf_nat br_netfilter overlay rpcrdma ib_iser libisc=
si scsi_transport_iscsi rdma_cm iw_cm ib_cm ib_core fuse [last unloaded: nf=
_tables]
> [  875.749118] CR2: 0000000000000028
> [  875.749415] ---[ end trace 0000000000000000 ]---
> [  875.749415] BUG: kernel NULL pointer dereference, address: 00000000000=
00028
> [  875.749614] RIP: 0010:vfs_setlease+0x27/0x70
> [  875.750031] #PF: supervisor read access in kernel mode
> [  875.750214] Code: ff ff 90 0f 1f 44 00 00 41 54 49 89 d4 55 48 89 fd 4=
8 83 ec 10 48 85 d2 74 06 48 83 fe 02 75 1f 48 8b 45 28 4c 89 e2 48 89 ef <=
48> 8b 80 d0 00 00 00 48 85 c0 74 2c 48 83 c4 10 5d 41 5c ff e0 48
> [  875.750521] #PF: error_code(0x0000) - not-present page
> [  875.751290] RSP: 0018:ffff88810378bdb0 EFLAGS: 00010246
> [  875.751596] PGD 0
> [  875.751766]
> [  875.752079] P4D 0
> [  875.752173] RAX: 0000000000000000 RBX: ffff88824866c000 RCX: ffff88810=
378bdd8
> [  875.752276]
> [  875.752371] RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffff88812=
560a200
> [  875.752797] Oops: 0000 [#6] SMP
> [  875.752874] RBP: ffff88812560a200 R08: ffff8881da5ecf00 R09: ffffffff8=
24064e0
> [  875.753291] CPU: 4 PID: 12145 Comm: nfsd Tainted: G      D W          =
6.1.0-rc7_ac3a2585f018 #1
> [  875.753429] R10: 0000000000000000 R11: 0000000000000000 R12: 000000000=
0000000
> [  875.753848] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS r=
el-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> [  875.754219] R13: ffff8881da5ecf00 R14: ffff888110e62028 R15: ffff88811=
0e621a0
> [  875.754638] RIP: 0010:vfs_setlease+0x1d/0x70
> [  875.755100] FS:  0000000000000000(0000) GS:ffff88852c900000(0000) knlG=
S:0000000000000000
> [  875.755522] Code: 19 37 76 00 49 89 ee e9 ac fc ff ff 90 0f 1f 44 00 0=
0 41 54 49 89 d4 55 48 89 fd 48 83 ec 10 48 85 d2 74 06 48 83 fe 02 75 1f <=
48> 8b 45 28 4c 89 e2 48 89 ef 48 8b 80 d0 00 00 00 48 85 c0 74 2c
> [  875.755709] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  875.756176] RSP: 0018:ffff88811d127db0 EFLAGS: 00010246
> [  875.756949] CR2: 0000000000000028 CR3: 0000000105b6e003 CR4: 000000000=
0372ea0
> [  875.757293]
> [  875.757527] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [  875.757946] RAX: ffff888180715068 RBX: ffff8881034da118 RCX: ffff88811=
d127dd8
> [  875.758023] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [  875.758441] RDX: 0000000000000000 RSI: 0000000000000002 RDI: 000000000=
0000000
> [  875.768979] RBP: 0000000000000000 R08: ffff888248d72a00 R09: ffffffff8=
24067b0
> [  875.769725] R10: 0000000000000000 R11: 0000000000000000 R12: 000000000=
0000000
> [  875.770466] R13: ffff888248d72a00 R14: ffff888110e5a028 R15: ffff88811=
0e5a1a0
> [  875.771201] FS:  0000000000000000(0000) GS:ffff88852ca00000(0000) knlG=
S:0000000000000000
> [  875.772096] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  875.772725] CR2: 0000000000000028 CR3: 0000000113338003 CR4: 000000000=
0372ea0
> [  875.773464] Call Trace:
> [  875.773824]  <TASK>
> [  875.774160]  destroy_unhashed_deleg+0x58/0xc0 [nfsd]
> [  875.774737]  nfsd4_delegreturn+0x119/0x150 [nfsd]
> [  875.775292]  nfsd4_proc_compound+0x282/0x5d0 [nfsd]
> [  875.775863]  nfsd_dispatch+0x15d/0x250 [nfsd]
> [  875.776398]  svc_process_common+0x2b6/0x4d0
> [  875.776910]  ? nfsd_svc+0x330/0x330 [nfsd]
> [  875.777411]  ? nfsd_shutdown_threads+0x90/0x90 [nfsd]
> [  875.777994]  svc_process+0xd4/0xf0
> [  875.778437]  nfsd+0xcb/0x180 [nfsd]
> [  875.778894]  kthread+0xb9/0xe0
> [  875.779305]  ? kthread_complete_and_exit+0x20/0x20
> [  875.779859]  ret_from_fork+0x1f/0x30
> [  875.780316]  </TASK>
> [  875.780651] Modules linked in: nfsd iptable_raw bonding mlx5_vfio_pci =
rdma_ucm ipip tunnel4 ip_gre ib_umad nf_tables vfio_pci vfio_pci_core vfio_=
virqfd vfio_iommu_type1 mlx5_ib vfio ib_uverbs ib_ipoib mlx5_core ip6_gre g=
re ip6_tunnel tunnel6 geneve nfnetlink_cttimeout openvswitch nsh vhost_net =
vhost vhost_iotlb tap ip6table_mangle ip6table_nat iptable_mangle ip6table_=
filter ip6_tables xt_conntrack xt_MASQUERADE nf_conntrack_netlink nfnetlink=
 xt_addrtype iptable_nat nf_nat br_netfilter overlay rpcrdma ib_iser libisc=
si scsi_transport_iscsi rdma_cm iw_cm ib_cm ib_core fuse [last unloaded: nf=
_tables]
> [  875.785657] CR2: 0000000000000028
> [  875.786087] ---[ end trace 0000000000000000 ]---
> [  875.786088] BUG: kernel NULL pointer dereference, address: 00000000000=
00028
> [  875.786366] RIP: 0010:vfs_setlease+0x27/0x70
> [  875.786700] #PF: supervisor read access in kernel mode
> [  875.786962] Code: ff ff 90 0f 1f 44 00 00 41 54 49 89 d4 55 48 89 fd 4=
8 83 ec 10 48 85 d2 74 06 48 83 fe 02 75 1f 48 8b 45 28 4c 89 e2 48 89 ef <=
48> 8b 80 d0 00 00 00 48 85 c0 74 2c 48 83 c4 10 5d 41 5c ff e0 48
> [  875.787209] #PF: error_code(0x0000) - not-present page
> [  875.788286] RSP: 0018:ffff88810378bdb0 EFLAGS: 00010246
> [  875.788528] PGD 0
> [  875.788794]
> [  875.789047] P4D 0
> [  875.789181] RAX: 0000000000000000 RBX: ffff88824866c000 RCX: ffff88810=
378bdd8
> [  875.789264]
> [  875.789396] RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffff88812=
560a200
> [  875.789735] Oops: 0000 [#7] SMP
> [  875.789841] RBP: ffff88812560a200 R08: ffff8881da5ecf00 R09: ffffffff8=
24064e0
> [  875.790181] CPU: 0 PID: 12141 Comm: nfsd Tainted: G      D W          =
6.1.0-rc7_ac3a2585f018 #1
> [  875.790380] R10: 0000000000000000 R11: 0000000000000000 R12: 000000000=
0000000
> [  875.790715] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS r=
el-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> [  875.791221] R13: ffff8881da5ecf00 R14: ffff888110e62028 R15: ffff88811=
0e621a0
> [  875.791561] RIP: 0010:vfs_setlease+0x1d/0x70
> [  875.792214] FS:  0000000000000000(0000) GS:ffff88852ca00000(0000) knlG=
S:0000000000000000
> [  875.792552] Code: 19 37 76 00 49 89 ee e9 ac fc ff ff 90 0f 1f 44 00 0=
0 41 54 49 89 d4 55 48 89 fd 48 83 ec 10 48 85 d2 74 06 48 83 fe 02 75 1f <=
48> 8b 45 28 4c 89 e2 48 89 ef 48 8b 80 d0 00 00 00 48 85 c0 74 2c
> [  875.792825] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  875.793203] RSP: 0018:ffff888244b23db0 EFLAGS: 00010246
> [  875.794279] CR2: 0000000000000028 CR3: 0000000113338003 CR4: 000000000=
0372ea0
> [  875.794556]
> [  875.801646] RAX: ffff8881807151a0 RBX: ffff8881034da460 RCX: ffff88824=
4b23dd8
> [  875.802232] RDX: 0000000000000000 RSI: 0000000000000002 RDI: 000000000=
0000000
> [  875.802821] RBP: 0000000000000000 R08: ffff888248d72f00 R09: ffffffff8=
24062b8
> [  875.812350] R10: 0000000000000000 R11: 0000000000000000 R12: 000000000=
0000000
> [  875.812947] R13: ffff888248d72f00 R14: ffff888245018028 R15: ffff88824=
50181a0
> [  875.813536] FS:  0000000000000000(0000) GS:ffff88852c800000(0000) knlG=
S:0000000000000000
> [  875.814245] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  875.814741] CR2: 0000000000000028 CR3: 00000001ca27d001 CR4: 000000000=
0372eb0
> [  875.815331] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [  875.815919] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [  875.816504] Call Trace:
> [  875.816801]  <TASK>
> [  875.817061]  destroy_unhashed_deleg+0x58/0xc0 [nfsd]
> [  875.817525]  nfsd4_delegreturn+0x119/0x150 [nfsd]
> [  875.817968]  nfsd4_proc_compound+0x282/0x5d0 [nfsd]
> [  875.818422]  nfsd_dispatch+0x15d/0x250 [nfsd]
> [  875.818838]  svc_process_common+0x2b6/0x4d0
> [  875.819238]  ? nfsd_svc+0x330/0x330 [nfsd]
> [  875.819642]  ? nfsd_shutdown_threads+0x90/0x90 [nfsd]
> [  875.820101]  svc_process+0xd4/0xf0
> [  875.820449]  nfsd+0xcb/0x180 [nfsd]
> [  875.820821]  kthread+0xb9/0xe0
> [  875.821149]  ? kthread_complete_and_exit+0x20/0x20
> [  875.821590]  ret_from_fork+0x1f/0x30
> [  875.821946]  </TASK>
> [  875.822213] Modules linked in: nfsd iptable_raw bonding mlx5_vfio_pci =
rdma_ucm ipip tunnel4 ip_gre ib_umad nf_tables vfio_pci vfio_pci_core vfio_=
virqfd vfio_iommu_type1 mlx5_ib vfio ib_uverbs ib_ipoib mlx5_core ip6_gre g=
re ip6_tunnel tunnel6 geneve nfnetlink_cttimeout openvswitch nsh vhost_net =
vhost vhost_iotlb tap ip6table_mangle ip6table_nat iptable_mangle ip6table_=
filter ip6_tables xt_conntrack xt_MASQUERADE nf_conntrack_netlink nfnetlink=
 xt_addrtype iptable_nat nf_nat br_netfilter overlay rpcrdma ib_iser libisc=
si scsi_transport_iscsi rdma_cm iw_cm ib_cm ib_core fuse [last unloaded: nf=
_tables]
> [  875.826147] CR2: 0000000000000028
> [  875.826491] ---[ end trace 0000000000000000 ]---
> [  875.826492] BUG: kernel NULL pointer dereference, address: 00000000000=
000d0
> [  875.826715] RIP: 0010:vfs_setlease+0x27/0x70
> [  875.827026] #PF: supervisor read access in kernel mode
> [  875.827237] Code: ff ff 90 0f 1f 44 00 00 41 54 49 89 d4 55 48 89 fd 4=
8 83 ec 10 48 85 d2 74 06 48 83 fe 02 75 1f 48 8b 45 28 4c 89 e2 48 89 ef <=
48> 8b 80 d0 00 00 00 48 85 c0 74 2c 48 83 c4 10 5d 41 5c ff e0 48
> [  875.827455] #PF: error_code(0x0000) - not-present page
> [  875.828299] RSP: 0018:ffff88810378bdb0 EFLAGS: 00010246
> [  875.828516] PGD 0 P4D 0
> [  875.828722]
> [  875.828943]
> [  875.829075] RAX: 0000000000000000 RBX: ffff88824866c000 RCX: ffff88810=
378bdd8
> [  875.829152] Oops: 0000 [#8] SMP
> [  875.829234] RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffff88812=
560a200
> [  875.829529] CPU: 6 PID: 12144 Comm: nfsd Tainted: G      D W          =
6.1.0-rc7_ac3a2585f018 #1
> [  875.829690] RBP: ffff88812560a200 R08: ffff8881da5ecf00 R09: ffffffff8=
24064e0
> [  875.829993] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS r=
el-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> [  875.830400] R10: 0000000000000000 R11: 0000000000000000 R12: 000000000=
0000000
> [  875.830699] RIP: 0010:vfs_setlease+0x27/0x70
> [  875.831221] R13: ffff8881da5ecf00 R14: ffff888110e62028 R15: ffff88811=
0e621a0
> [  875.831516] Code: ff ff 90 0f 1f 44 00 00 41 54 49 89 d4 55 48 89 fd 4=
8 83 ec 10 48 85 d2 74 06 48 83 fe 02 75 1f 48 8b 45 28 4c 89 e2 48 89 ef <=
48> 8b 80 d0 00 00 00 48 85 c0 74 2c 48 83 c4 10 5d 41 5c ff e0 48
> [  875.831723] FS:  0000000000000000(0000) GS:ffff88852c800000(0000) knlG=
S:0000000000000000
> [  875.832014] RSP: 0018:ffff88811467fdb0 EFLAGS: 00010246
> [  875.832874] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  875.833205]
> [  875.833454] CR2: 0000000000000028 CR3: 00000001ca27d001 CR4: 000000000=
0372eb0
> [  875.833698] RAX: 0000000000000000 RBX: ffff88824866c460 RCX: ffff88811=
467fdd8
> [  875.833784] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [  875.834078] RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffff88812=
560b000
> [  875.834411] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [  875.834706] RBP: ffff88812560b000 R08: ffff8881dd381300 R09: ffffffff8=
24069c0
> [  875.841961] R10: 0000000000000000 R11: 0000000000000000 R12: 000000000=
0000000
> [  875.842471] R13: ffff8881dd381300 R14: ffff8881010ca028 R15: ffff88810=
10ca1a0
> [  875.842999] FS:  0000000000000000(0000) GS:ffff88852cb00000(0000) knlG=
S:0000000000000000
> [  875.843608] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  875.844056] CR2: 00000000000000d0 CR3: 0000000105b6e002 CR4: 000000000=
0372ea0
> [  875.844565] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [  875.845081] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [  875.845590] Call Trace:
> [  875.845835]  <TASK>
> [  875.846072]  destroy_unhashed_deleg+0x58/0xc0 [nfsd]
> [  875.846465]  nfsd4_delegreturn+0x119/0x150 [nfsd]
> [  875.846850]  nfsd4_proc_compound+0x282/0x5d0 [nfsd]
> [  875.847263]  nfsd_dispatch+0x15d/0x250 [nfsd]
> [  875.847627]  svc_process_common+0x2b6/0x4d0
> [  875.847968]  ? nfsd_svc+0x330/0x330 [nfsd]
> [  875.848322]  ? nfsd_shutdown_threads+0x90/0x90 [nfsd]
> [  875.848720]  svc_process+0xd4/0xf0
> [  875.849025]  nfsd+0xcb/0x180 [nfsd]
> [  875.849344]  kthread+0xb9/0xe0
> [  875.849625]  ? kthread_complete_and_exit+0x20/0x20
> [  875.850001]  ret_from_fork+0x1f/0x30
> [  875.850313]  </TASK>
> [  875.850539] Modules linked in: nfsd iptable_raw bonding mlx5_vfio_pci =
rdma_ucm ipip tunnel4 ip_gre ib_umad nf_tables vfio_pci vfio_pci_core vfio_=
virqfd vfio_iommu_type1 mlx5_ib vfio ib_uverbs ib_ipoib mlx5_core ip6_gre g=
re ip6_tunnel tunnel6 geneve nfnetlink_cttimeout openvswitch nsh vhost_net =
vhost vhost_iotlb tap ip6table_mangle ip6table_nat iptable_mangle ip6table_=
filter ip6_tables xt_conntrack xt_MASQUERADE nf_conntrack_netlink nfnetlink=
 xt_addrtype iptable_nat nf_nat br_netfilter overlay rpcrdma ib_iser libisc=
si scsi_transport_iscsi rdma_cm iw_cm ib_cm ib_core fuse [last unloaded: nf=
_tables]
> [  875.853944] CR2: 00000000000000d0
> [  875.854240] ---[ end trace 0000000000000000 ]---
>=20
>> ---
>> fs/nfsd/filecache.c | 247 ++++++++++++++++++++++----------------------
>> fs/nfsd/trace.h     |   1 +
>> 2 files changed, 123 insertions(+), 125 deletions(-)
>>=20
>> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
>> index 0bf3727455e2..e67297ad12bf 100644
>> --- a/fs/nfsd/filecache.c
>> +++ b/fs/nfsd/filecache.c
>> @@ -303,8 +303,7 @@ nfsd_file_alloc(struct nfsd_file_lookup_key *key, un=
signed int may)
>> 		if (key->gc)
>> 			__set_bit(NFSD_FILE_GC, &nf->nf_flags);
>> 		nf->nf_inode =3D key->inode;
>> -		/* nf_ref is pre-incremented for hash table */
>> -		refcount_set(&nf->nf_ref, 2);
>> +		refcount_set(&nf->nf_ref, 1);
>> 		nf->nf_may =3D key->need;
>> 		nf->nf_mark =3D NULL;
>> 	}
>> @@ -353,24 +352,35 @@ nfsd_file_unhash(struct nfsd_file *nf)
>> 	return false;
>> }
>>=20
>> -static bool
>> +static void
>> nfsd_file_free(struct nfsd_file *nf)
>> {
>> 	s64 age =3D ktime_to_ms(ktime_sub(ktime_get(), nf->nf_birthtime));
>> -	bool flush =3D false;
>>=20
>> 	trace_nfsd_file_free(nf);
>>=20
>> 	this_cpu_inc(nfsd_file_releases);
>> 	this_cpu_add(nfsd_file_total_age, age);
>>=20
>> +	nfsd_file_unhash(nf);
>> +
>> +	/*
>> +	 * We call fsync here in order to catch writeback errors. It's not
>> +	 * strictly required by the protocol, but an nfsd_file coule get
>> +	 * evicted from the cache before a COMMIT comes in. If another
>> +	 * task were to open that file in the interim and scrape the error,
>> +	 * then the client may never see it. By calling fsync here, we ensure
>> +	 * that writeback happens before the entry is freed, and that any
>> +	 * errors reported result in the write verifier changing.
>> +	 */
>> +	nfsd_file_fsync(nf);
>> +
>> 	if (nf->nf_mark)
>> 		nfsd_file_mark_put(nf->nf_mark);
>> 	if (nf->nf_file) {
>> 		get_file(nf->nf_file);
>> 		filp_close(nf->nf_file, NULL);
>> 		fput(nf->nf_file);
>> -		flush =3D true;
>> 	}
>>=20
>> 	/*
>> @@ -378,10 +388,9 @@ nfsd_file_free(struct nfsd_file *nf)
>> 	 * WARN and leak it to preserve system stability.
>> 	 */
>> 	if (WARN_ON_ONCE(!list_empty(&nf->nf_lru)))
>> -		return flush;
>> +		return;
>>=20
>> 	call_rcu(&nf->nf_rcu, nfsd_file_slab_free);
>> -	return flush;
>> }
>>=20
>> static bool
>> @@ -397,17 +406,23 @@ nfsd_file_check_writeback(struct nfsd_file *nf)
>> 		mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK);
>> }
>>=20
>> -static void nfsd_file_lru_add(struct nfsd_file *nf)
>> +static bool nfsd_file_lru_add(struct nfsd_file *nf)
>> {
>> 	set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
>> -	if (list_lru_add(&nfsd_file_lru, &nf->nf_lru))
>> +	if (list_lru_add(&nfsd_file_lru, &nf->nf_lru)) {
>> 		trace_nfsd_file_lru_add(nf);
>> +		return true;
>> +	}
>> +	return false;
>> }
>>=20
>> -static void nfsd_file_lru_remove(struct nfsd_file *nf)
>> +static bool nfsd_file_lru_remove(struct nfsd_file *nf)
>> {
>> -	if (list_lru_del(&nfsd_file_lru, &nf->nf_lru))
>> +	if (list_lru_del(&nfsd_file_lru, &nf->nf_lru)) {
>> 		trace_nfsd_file_lru_del(nf);
>> +		return true;
>> +	}
>> +	return false;
>> }
>>=20
>> struct nfsd_file *
>> @@ -418,86 +433,80 @@ nfsd_file_get(struct nfsd_file *nf)
>> 	return NULL;
>> }
>>=20
>> -static void
>> +/**
>> + * nfsd_file_unhash_and_queue - unhash a file and queue it to the dispo=
se list
>> + * @nf: nfsd_file to be unhashed and queued
>> + * @dispose: list to which it should be queued
>> + *
>> + * Attempt to unhash a nfsd_file and queue it to the given list. Each f=
ile
>> + * will have a reference held on behalf of the list. That reference may=
 come
>> + * from the LRU, or we may need to take one. If we can't get a referenc=
e,
>> + * ignore it altogether.
>> + */
>> +static bool
>> nfsd_file_unhash_and_queue(struct nfsd_file *nf, struct list_head *dispo=
se)
>> {
>> 	trace_nfsd_file_unhash_and_queue(nf);
>> 	if (nfsd_file_unhash(nf)) {
>> -		/* caller must call nfsd_file_dispose_list() later */
>> -		nfsd_file_lru_remove(nf);
>> +		/*
>> +		 * If we remove it from the LRU, then just use that
>> +		 * reference for the dispose list. Otherwise, we need
>> +		 * to take a reference. If that fails, just ignore
>> +		 * the file altogether.
>> +		 */
>> +		if (!nfsd_file_lru_remove(nf) && !nfsd_file_get(nf))
>> +			return false;
>> 		list_add(&nf->nf_lru, dispose);
>> +		return true;
>> 	}
>> +	return false;
>> }
>>=20
>> -static void
>> -nfsd_file_put_noref(struct nfsd_file *nf)
>> -{
>> -	trace_nfsd_file_put(nf);
>> -
>> -	if (refcount_dec_and_test(&nf->nf_ref)) {
>> -		WARN_ON(test_bit(NFSD_FILE_HASHED, &nf->nf_flags));
>> -		nfsd_file_lru_remove(nf);
>> -		nfsd_file_free(nf);
>> -	}
>> -}
>> -
>> -static void
>> -nfsd_file_unhash_and_put(struct nfsd_file *nf)
>> -{
>> -	if (nfsd_file_unhash(nf))
>> -		nfsd_file_put_noref(nf);
>> -}
>> -
>> +/**
>> + * nfsd_file_put - put the reference to a nfsd_file
>> + * @nf: nfsd_file of which to put the reference
>> + *
>> + * Put a reference to a nfsd_file. In the v4 case, we just put the
>> + * reference immediately. In the GC case, if the reference would be
>> + * the last one, the put it on the LRU instead to be cleaned up later.
>> + */
>> void
>> nfsd_file_put(struct nfsd_file *nf)
>> {
>> 	might_sleep();
>> +	trace_nfsd_file_put(nf);
>>=20
>> -	if (test_bit(NFSD_FILE_GC, &nf->nf_flags))
>> -		nfsd_file_lru_add(nf);
>> -	else if (refcount_read(&nf->nf_ref) =3D=3D 2)
>> -		nfsd_file_unhash_and_put(nf);
>> -
>> -	if (!test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
>> -		nfsd_file_fsync(nf);
>> -		nfsd_file_put_noref(nf);
>> -	} else if (nf->nf_file && test_bit(NFSD_FILE_GC, &nf->nf_flags)) {
>> -		nfsd_file_put_noref(nf);
>> -		nfsd_file_schedule_laundrette();
>> -	} else
>> -		nfsd_file_put_noref(nf);
>> -}
>> -
>> -static void
>> -nfsd_file_dispose_list(struct list_head *dispose)
>> -{
>> -	struct nfsd_file *nf;
>> -
>> -	while(!list_empty(dispose)) {
>> -		nf =3D list_first_entry(dispose, struct nfsd_file, nf_lru);
>> -		list_del_init(&nf->nf_lru);
>> -		nfsd_file_fsync(nf);
>> -		nfsd_file_put_noref(nf);
>> +	/*
>> +	 * The HASHED check is racy. We may end up with the occasional
>> +	 * unhashed entry on the LRU, but they should get cleaned up
>> +	 * like any other.
>> +	 */
>> +	if (test_bit(NFSD_FILE_GC, &nf->nf_flags) &&
>> +	    test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
>> +		/*
>> +		 * If this is the last reference (nf_ref =3D=3D 1), then transfer
>> +		 * it to the LRU. If the add to the LRU fails, just put it as
>> +		 * usual.
>> +		 */
>> +		if (refcount_dec_not_one(&nf->nf_ref) || nfsd_file_lru_add(nf)) {
>> +			nfsd_file_schedule_laundrette();
>> +			return;
>> +		}
>> 	}
>> +	if (refcount_dec_and_test(&nf->nf_ref))
>> +		nfsd_file_free(nf);
>> }
>>=20
>> static void
>> -nfsd_file_dispose_list_sync(struct list_head *dispose)
>> +nfsd_file_dispose_list(struct list_head *dispose)
>> {
>> -	bool flush =3D false;
>> 	struct nfsd_file *nf;
>>=20
>> 	while(!list_empty(dispose)) {
>> 		nf =3D list_first_entry(dispose, struct nfsd_file, nf_lru);
>> 		list_del_init(&nf->nf_lru);
>> -		nfsd_file_fsync(nf);
>> -		if (!refcount_dec_and_test(&nf->nf_ref))
>> -			continue;
>> -		if (nfsd_file_free(nf))
>> -			flush =3D true;
>> +		nfsd_file_free(nf);
>> 	}
>> -	if (flush)
>> -		flush_delayed_fput();
>> }
>>=20
>> static void
>> @@ -567,21 +576,8 @@ nfsd_file_lru_cb(struct list_head *item, struct lis=
t_lru_one *lru,
>> 	struct list_head *head =3D arg;
>> 	struct nfsd_file *nf =3D list_entry(item, struct nfsd_file, nf_lru);
>>=20
>> -	/*
>> -	 * Do a lockless refcount check. The hashtable holds one reference, so
>> -	 * we look to see if anything else has a reference, or if any have
>> -	 * been put since the shrinker last ran. Those don't get unhashed and
>> -	 * released.
>> -	 *
>> -	 * Note that in the put path, we set the flag and then decrement the
>> -	 * counter. Here we check the counter and then test and clear the flag=
.
>> -	 * That order is deliberate to ensure that we can do this locklessly.
>> -	 */
>> -	if (refcount_read(&nf->nf_ref) > 1) {
>> -		list_lru_isolate(lru, &nf->nf_lru);
>> -		trace_nfsd_file_gc_in_use(nf);
>> -		return LRU_REMOVED;
>> -	}
>> +	/* We should only be dealing with GC entries here */
>> +	WARN_ON_ONCE(!test_bit(NFSD_FILE_GC, &nf->nf_flags));
>>=20
>> 	/*
>> 	 * Don't throw out files that are still undergoing I/O or
>> @@ -592,40 +588,30 @@ nfsd_file_lru_cb(struct list_head *item, struct li=
st_lru_one *lru,
>> 		return LRU_SKIP;
>> 	}
>>=20
>> +	/* If it was recently added to the list, skip it */
>> 	if (test_and_clear_bit(NFSD_FILE_REFERENCED, &nf->nf_flags)) {
>> 		trace_nfsd_file_gc_referenced(nf);
>> 		return LRU_ROTATE;
>> 	}
>>=20
>> -	if (!test_and_clear_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
>> -		trace_nfsd_file_gc_hashed(nf);
>> -		return LRU_SKIP;
>> +	/*
>> +	 * Put the reference held on behalf of the LRU. If it wasn't the last
>> +	 * one, then just remove it from the LRU and ignore it.
>> +	 */
>> +	if (!refcount_dec_and_test(&nf->nf_ref)) {
>> +		trace_nfsd_file_gc_in_use(nf);
>> +		list_lru_isolate(lru, &nf->nf_lru);
>> +		return LRU_REMOVED;
>> 	}
>>=20
>> +	/* Refcount went to zero. Unhash it and queue it to the dispose list *=
/
>> +	nfsd_file_unhash(nf);
>> 	list_lru_isolate_move(lru, &nf->nf_lru, head);
>> 	this_cpu_inc(nfsd_file_evictions);
>> 	trace_nfsd_file_gc_disposed(nf);
>> 	return LRU_REMOVED;
>> }
>>=20
>> -/*
>> - * Unhash items on @dispose immediately, then queue them on the
>> - * disposal workqueue to finish releasing them in the background.
>> - *
>> - * cel: Note that between the time list_lru_shrink_walk runs and
>> - * now, these items are in the hash table but marked unhashed.
>> - * Why release these outside of lru_cb ? There's no lock ordering
>> - * problem since lru_cb currently takes no lock.
>> - */
>> -static void nfsd_file_gc_dispose_list(struct list_head *dispose)
>> -{
>> -	struct nfsd_file *nf;
>> -
>> -	list_for_each_entry(nf, dispose, nf_lru)
>> -		nfsd_file_hash_remove(nf);
>> -	nfsd_file_dispose_list_delayed(dispose);
>> -}
>> -
>> static void
>> nfsd_file_gc(void)
>> {
>> @@ -635,7 +621,7 @@ nfsd_file_gc(void)
>> 	ret =3D list_lru_walk(&nfsd_file_lru, nfsd_file_lru_cb,
>> 			    &dispose, list_lru_count(&nfsd_file_lru));
>> 	trace_nfsd_file_gc_removed(ret, list_lru_count(&nfsd_file_lru));
>> -	nfsd_file_gc_dispose_list(&dispose);
>> +	nfsd_file_dispose_list_delayed(&dispose);
>> }
>>=20
>> static void
>> @@ -660,7 +646,7 @@ nfsd_file_lru_scan(struct shrinker *s, struct shrink=
_control *sc)
>> 	ret =3D list_lru_shrink_walk(&nfsd_file_lru, sc,
>> 				   nfsd_file_lru_cb, &dispose);
>> 	trace_nfsd_file_shrinker_removed(ret, list_lru_count(&nfsd_file_lru));
>> -	nfsd_file_gc_dispose_list(&dispose);
>> +	nfsd_file_dispose_list_delayed(&dispose);
>> 	return ret;
>> }
>>=20
>> @@ -671,8 +657,11 @@ static struct shrinker	nfsd_file_shrinker =3D {
>> };
>>=20
>> /*
>> - * Find all cache items across all net namespaces that match @inode and
>> - * move them to @dispose. The lookup is atomic wrt nfsd_file_acquire().
>> + * Find all cache items across all net namespaces that match @inode, un=
hash
>> + * them, take references and then put them on @dispose if that was succ=
essful.
>> + *
>> + * The nfsd_file objects on the list will be unhashed, and each will ha=
ve a
>> + * reference taken.
>>  */
>> static unsigned int
>> __nfsd_file_close_inode(struct inode *inode, struct list_head *dispose)
>> @@ -690,8 +679,9 @@ __nfsd_file_close_inode(struct inode *inode, struct =
list_head *dispose)
>> 				       nfsd_file_rhash_params);
>> 		if (!nf)
>> 			break;
>> -		nfsd_file_unhash_and_queue(nf, dispose);
>> -		count++;
>> +
>> +		if (nfsd_file_unhash_and_queue(nf, dispose))
>> +			count++;
>> 	} while (1);
>> 	rcu_read_unlock();
>> 	return count;
>> @@ -703,15 +693,23 @@ __nfsd_file_close_inode(struct inode *inode, struc=
t list_head *dispose)
>>  *
>>  * Unhash and put all cache item associated with @inode.
>>  */
>> -static void
>> +static unsigned int
>> nfsd_file_close_inode(struct inode *inode)
>> {
>> -	LIST_HEAD(dispose);
>> +	struct nfsd_file *nf;
>> 	unsigned int count;
>> +	LIST_HEAD(dispose);
>>=20
>> 	count =3D __nfsd_file_close_inode(inode, &dispose);
>> 	trace_nfsd_file_close_inode(inode, count);
>> -	nfsd_file_dispose_list_delayed(&dispose);
>> +	while(!list_empty(&dispose)) {
>> +		nf =3D list_first_entry(&dispose, struct nfsd_file, nf_lru);
>> +		list_del_init(&nf->nf_lru);
>> +		trace_nfsd_file_closing(nf);
>> +		if (refcount_dec_and_test(&nf->nf_ref))
>> +			nfsd_file_free(nf);
>> +	}
>> +	return count;
>> }
>>=20
>> /**
>> @@ -723,19 +721,15 @@ nfsd_file_close_inode(struct inode *inode)
>> void
>> nfsd_file_close_inode_sync(struct inode *inode)
>> {
>> -	LIST_HEAD(dispose);
>> -	unsigned int count;
>> -
>> -	count =3D __nfsd_file_close_inode(inode, &dispose);
>> -	trace_nfsd_file_close_inode_sync(inode, count);
>> -	nfsd_file_dispose_list_sync(&dispose);
>> +	if (nfsd_file_close_inode(inode))
>> +		flush_delayed_fput();
>> }
>>=20
>> /**
>>  * nfsd_file_delayed_close - close unused nfsd_files
>>  * @work: dummy
>>  *
>> - * Walk the LRU list and close any entries that have not been used sinc=
e
>> + * Walk the LRU list and destroy any entries that have not been used si=
nce
>>  * the last scan.
>>  */
>> static void
>> @@ -1056,8 +1050,10 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, stru=
ct svc_fh *fhp,
>> 	rcu_read_lock();
>> 	nf =3D rhashtable_lookup(&nfsd_file_rhash_tbl, &key,
>> 			       nfsd_file_rhash_params);
>> -	if (nf)
>> -		nf =3D nfsd_file_get(nf);
>> +	if (nf) {
>> +		if (!nfsd_file_lru_remove(nf))
>> +			nf =3D nfsd_file_get(nf);
>> +	}
>> 	rcu_read_unlock();
>> 	if (nf)
>> 		goto wait_for_construction;
>> @@ -1092,11 +1088,11 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, str=
uct svc_fh *fhp,
>> 			goto out;
>> 		}
>> 		open_retry =3D false;
>> -		nfsd_file_put_noref(nf);
>> +		if (refcount_dec_and_test(&nf->nf_ref))
>> +			nfsd_file_free(nf);
>> 		goto retry;
>> 	}
>>=20
>> -	nfsd_file_lru_remove(nf);
>> 	this_cpu_inc(nfsd_file_cache_hits);
>>=20
>> 	status =3D nfserrno(nfsd_open_break_lease(file_inode(nf->nf_file), may_=
flags));
>> @@ -1106,7 +1102,8 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struc=
t svc_fh *fhp,
>> 			this_cpu_inc(nfsd_file_acquisitions);
>> 		*pnf =3D nf;
>> 	} else {
>> -		nfsd_file_put(nf);
>> +		if (refcount_dec_and_test(&nf->nf_ref))
>> +			nfsd_file_free(nf);
>> 		nf =3D NULL;
>> 	}
>>=20
>> @@ -1133,7 +1130,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struc=
t svc_fh *fhp,
>> 	 * then unhash.
>> 	 */
>> 	if (status !=3D nfs_ok || key.inode->i_nlink =3D=3D 0)
>> -		nfsd_file_unhash_and_put(nf);
>> +		nfsd_file_unhash(nf);
>> 	clear_bit_unlock(NFSD_FILE_PENDING, &nf->nf_flags);
>> 	smp_mb__after_atomic();
>> 	wake_up_bit(&nf->nf_flags, NFSD_FILE_PENDING);
>> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
>> index 940252482fd4..a44ded06af87 100644
>> --- a/fs/nfsd/trace.h
>> +++ b/fs/nfsd/trace.h
>> @@ -906,6 +906,7 @@ DEFINE_EVENT(nfsd_file_class, name, \
>> DEFINE_NFSD_FILE_EVENT(nfsd_file_free);
>> DEFINE_NFSD_FILE_EVENT(nfsd_file_unhash);
>> DEFINE_NFSD_FILE_EVENT(nfsd_file_put);
>> +DEFINE_NFSD_FILE_EVENT(nfsd_file_closing);
>> DEFINE_NFSD_FILE_EVENT(nfsd_file_unhash_and_queue);
>>=20
>> TRACE_EVENT(nfsd_file_alloc,

--
Chuck Lever



