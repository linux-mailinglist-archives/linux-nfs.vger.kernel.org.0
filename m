Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986B0700B0D
	for <lists+linux-nfs@lfdr.de>; Fri, 12 May 2023 17:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241732AbjELPJh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 12 May 2023 11:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241729AbjELPJd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 12 May 2023 11:09:33 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145907DA7;
        Fri, 12 May 2023 08:09:33 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CF4AKZ017810;
        Fri, 12 May 2023 15:09:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=iF89ImWXue2gZftXswnw1n1r0DjSsxTNKnQhvqY2uM4=;
 b=ClYHHL67upSEhWS+TtmboszBu/VjaWRuQWzh0/MocltvHTJpv9FqwBa4rBMTioCXL1kI
 fgzomRPD/+xqenc6rEItUobT4L1oAPln8lIMlKdLGeRMLy07IW/S/3XalJkcZtynH8p3
 b5LWrG0TNj5ATf/zmjvveS4XEvCs9DxbdwLDMwbT4chume5RwBVQEQKWLnNdBzleZKzx
 eFlihc5dVNEIfFKWfBAADwdaIxCZf0oFsMtVnYI5wZn6Jf2durTw8voQaFUbYVdixu29
 GcAwDpUknU9ATP0v3tZSPzk8Cu9wTmkzNWnOIpnxf2d3h80ioGkkwk/ZQ6LBA9m1qPi7 UQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qhje7h8ee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 15:09:23 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34CESeGt011650;
        Fri, 12 May 2023 15:09:22 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qf814yhfw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 15:09:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ASOKSg7nZZv4zcS4I3if9Lbc9wtybpv8IFP1dKY9iWMzYGa4hGI/XND3oaDx1NPQjh7BgGoMOwUBCKhbP4wzCoCI99oMtRclEA98ZYVrY32vvcbHLY/vBBiLz0X3czNWr+IydOzcYcTAAnQqhOxqdVDxu1tLF8MBVXqFWz95d4j6ChjKWFiqAZQCBTFtjAo9XWiNiNZt5hwz42342WONGioH8DaXm9f9fX9qMfKXT4Wv9aoiwWVdT9eKrNzOACPCoKXt+nkopBUFP09AE+OOHhwTB5b7YXCW2upNNmoLTDU1hnXSD2SFivyOS8qXV7cJ8ov04+V/lqqx9b+db5hVJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iF89ImWXue2gZftXswnw1n1r0DjSsxTNKnQhvqY2uM4=;
 b=cjpmRG2ePxX7uTlyWT7vF/c6UuJbwAu/ncQiPfQg5I90/N6z8a61hUu2BLGEj/eWBEvWvkh42i5JHVwcoeMYVY4xlrgiVe4iVMZrRA7Xwyu+4NSGQYZ8GpuGFCfo4nTsJp070oEiwFUe6vR5l22rtd+YHohKiLMwClbeM9Q0VHb60Rlqknu/Ou7A5BlRI8rw2BkZABMtUHzmvzbH5QK568Njhnn8rE4/F0N+JYJ7x1SDo12kF2kCCZ2o3Fh7nqQCGt505we6pFlT1GyMx9Cj4/Za/XnBejoyapdUdQ0ohWzzv3j/5l+h0sCTzJWWqAs2woez9jcDzIqwgk1qfTPo8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iF89ImWXue2gZftXswnw1n1r0DjSsxTNKnQhvqY2uM4=;
 b=tNJv+FX/8FTipESbyjl7tf94ENnAz47BawjZKJRkYZE5rNxqKYpFP7CQDhP6QPVgWWqInXkjcTxNeu35m4/vn5El/7FeiJPhpX41gXvaN5e2RhIfF0rNWFpr635OQolxoZiJNAu6cHCkQ+KnuiSkLARdAueMDXBl4eWOCJUlUdU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW5PR10MB5761.namprd10.prod.outlook.com (2603:10b6:303:19a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Fri, 12 May
 2023 15:09:19 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6387.024; Fri, 12 May 2023
 15:09:19 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
CC:     Jeff Layton <jlayton@kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] NFSD: Remove all occurences of strlcpy
Thread-Topic: [PATCH v2] NFSD: Remove all occurences of strlcpy
Thread-Index: AQHZhOJYGV62rs3GkUCJMHqFG7AZcq9WvaEA
Date:   Fri, 12 May 2023 15:09:19 +0000
Message-ID: <109A2974-3AE0-48C6-8EE3-FADE95E8EF30@oracle.com>
References: <20230512145356.396567-1-azeemshaikh38@gmail.com>
In-Reply-To: <20230512145356.396567-1-azeemshaikh38@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MW5PR10MB5761:EE_
x-ms-office365-filtering-correlation-id: 8d7f86b9-e74c-422b-d765-08db52fadc1c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dEy+MDxRHkAbPNzwxV3VZt8vsWbevS3ZKAyGGk7NE0o4V5iT23k9gPgO6PQMEgEqnCjFvCE5GZ0Nt7CbsUGyuBaXhvF89apeNJrJ/bOqQVnYrylV7Mv2aYgnxQVxGjq/ATsiQWjjzow0bTEaYvtI+5uPkNFk0t/OQ/4DKZX/G9WnAGMLjXtLyzmWc6+mzaFORE7+oLDX9zUdRZcHJ6JDTqN8pYUcfVqKZgiJL8uiXQUaGWBWjyDuEDUP3Xjb7DitNf46pOnjbYoYTydBkAzSIvnKFihitE5MDFWnFpl66xxDPs8HIfw/Me/8z/tm/7vHE9l6YbT/5UfBf9hzLedu5x/qmuayAF+Y2RgO8ZEYYalivzEbCLLNhHN0gTAF9VRLyKwzXKKHK3dSDbsxsGHpdUhLy58qcdhZx8C84bTjQKxsHMQUat2mVOOQjeaLbFFjbJs7j731Iq+p6QAzgo7S7mq2hipEOfO3KvjHup+FtrI4fuCGRbnZrok8tSQEnaiybmkd3YHVLY2vhzAOEVPXiaWGfd4fX0ReZrHTWORkUtCusHKyHb2/+JOmj5gLWhbUNLpWZgdTPeje0QzBKFCHu5f3fUqsDtI5CLolHqTXusHkChq9ER7duo0EUXZ8bEf6ZIbDW1/IHELVljCljazIweacFyPkPZbccl2bn0qUwOWdLHux6b4FMoZInaT3evrKaqEZWfsghfwHLf60NkTUgA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(366004)(376002)(396003)(346002)(451199021)(122000001)(38100700002)(33656002)(71200400001)(26005)(36756003)(6486002)(6512007)(186003)(6506007)(53546011)(966005)(2616005)(54906003)(83380400001)(38070700005)(2906002)(5660300002)(41300700001)(66446008)(64756008)(316002)(4326008)(66556008)(76116006)(478600001)(6916009)(66476007)(91956017)(86362001)(8936002)(66946007)(8676002)(156123004)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?87Cy4X07sXxgDzAAwAf9ki36ytmKa/TeQxQCitEEdG8elXPykyeJ+RecCiea?=
 =?us-ascii?Q?Mo5tayW16oOEZ3+4WzXoemcCaxDGuNoxqK+qs28PTVzrvBYHFeaLphr11jVF?=
 =?us-ascii?Q?in3ysAnKYyL/FhZ1pmazJ6FJvRzEhixtYON1lZjMQV2pu3UUJ23UT8ITWmlQ?=
 =?us-ascii?Q?mXEw1hBJdAN+ZXqfEMMqVKoBW/dd4LFMxbzyDb4XUDhcZHfO0KEeEa5BbBTT?=
 =?us-ascii?Q?h2IGbs2OhqQvju8ycEoVfBLJbzN1VuTpksJF0OvJSK91FulcgzXrKeGENSwv?=
 =?us-ascii?Q?RDANWs0hzJjGN+gjji8HCueZhRHPBFAfs7jczLZSZFbUbLCaY1tZqBMHRVJl?=
 =?us-ascii?Q?VbW2b61IvHfOU7PgFZQmRH10nmXfsZ9mmpfJBHjGPNuyX/FYFTThl/z+nSjW?=
 =?us-ascii?Q?nn4aD+1F39RuGaYYdhjkPLHM1D0/T6rKt+QHC4IRzc2QM4A9f+K2Vqm6yWh3?=
 =?us-ascii?Q?khA7voqLyQt3NWxr8qTzLSPtwvIQkkMawbnuMp9e91C1PzRb9suprNuTVZmW?=
 =?us-ascii?Q?tWZVzG0HQ48HmrYuxqeKsEyOpbvzcaqo6gQuBVhiP430IJ303Hgp9NYP2gQX?=
 =?us-ascii?Q?6Pj8pG8xY2zdBYHUqE+U613igWlQJYvj8hvVjfSO26BQwcpJD8r1gWKRSGSt?=
 =?us-ascii?Q?8J4hYzHBYGkCjYieVjDY1SNcd4LMRmrBwC3bbGQB8HJAVlGT3aHB31cB17bK?=
 =?us-ascii?Q?8c1OMOtVbOebSUfK8wEqsSVJ8xfE/03WvVUjxSJBNRRKJ43d79Zsl0LmZ3d9?=
 =?us-ascii?Q?mU2XbWxWlIsWv0SgFgD6DxmdzRiZMKWNNGqcYXFy6FLVxV1zgJDefC12N1J/?=
 =?us-ascii?Q?++8cDwBvLEzmu0vIWkaFHhpm8FXTxxm/wPGFZT+gKSyx+ftV4Rfk7dhCJopz?=
 =?us-ascii?Q?Il2Wdlr9UmwdTf04/CR0WrCRXg3KZ4m+ZQ2u1n55etE+H0eMWr7w6kbARt8J?=
 =?us-ascii?Q?eU+U5Ziy0LTFlU/g1FGCWfOwCsXrlNqdcmAX0f/jXg/h7ekMoBJXHl7edzxo?=
 =?us-ascii?Q?FYHjb/VVjT9dqMHrWugxI+7TmzCLk8jzFMDUzkVsn34HGdFrBB5IiiOLy8uf?=
 =?us-ascii?Q?dvIt6ZGZ3qxfXdTaQn+cqfgxQd6us/rhh5TXZklRnc9quNgdYEclReFd2FtP?=
 =?us-ascii?Q?7Aj/rEerl4NZhMnZUQsb9kXeZ6zQvD7Q23+Wsa1thTfZpAruXoQoZTruZrZy?=
 =?us-ascii?Q?oe6GkrBeL1J9V1IvKqFu1N/uzinzse4jJt6vy4QvAKNs86+HhBDAuPOFmYhh?=
 =?us-ascii?Q?NbRqUNf4duY34K8cvvVrSDyBvp5uLz9sQELdOWKcHA/GkqyfKcgZFu01M3PL?=
 =?us-ascii?Q?qGbe3ReSZb8W7AfI/sE3J7rNDSxUI6fneGviijJBXCeMEvnTHSO73mCLy+aJ?=
 =?us-ascii?Q?8bJ0w5CRbg0if4+hQkYmRF+5wrULali0XA2InBFu8wyvh3Azvt6MQp38PG3D?=
 =?us-ascii?Q?CNbqtc0FfqyT5KT1puedP+FQpVikKP2M5j1MAI25Jn8D+4BaW/SFEEEt3N6j?=
 =?us-ascii?Q?1F2OjTQ87Wl7i+3upudZyFOC1J/bXaieRiOW5MFoG+0eBH5oG2E6Fmh+07yZ?=
 =?us-ascii?Q?4pKnSL53S5qFr7otC389lU1DJ4+7PVXUW+Fkwp7jOESAt++Lj0327Xhv6qMc?=
 =?us-ascii?Q?Zg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <283ED3F722357B488108303B9FFE7064@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OkwDhZnb06AizUHe5lUEiDPkDip26tKV51cdoiltZHHGgHh66t5VxcDZludTGPyNjaXwJHiu+Kwdiaqs8OYd/W8Wwm8nLohxC08zUnIpVTypLj/GAMQCWzVfuDUGVqT+F7h1a8sxR4apc45QT+E1heS1QHY48bdMsLzChxm+Wam3wZAV6nV0cy5n2ZdmV7+BTSR8PXniy9M8Ah5Pc2DSvjKNLfkH7NU4CS4I7G61e7TxJ4iAbNe2H6gy10ULgmR/lB9duI7Z/qOAXIRxbcrLjlXyt/fWUYPjyEsys4xVQmFIXWqWf9xvn4HrbaChqBWwwH9Q/EgTzaoLv7uWEMfS8QJrslGkfkg4I7V25DJjz16sOh62heTJ8kNNmUf/dsMzXpK1W13FxHx3aC96kkqiPbsk5gXSjZ+VDdW+e+vPSWcRfF7Ya7tagyZVd+Z1ZnomYhU9/9POzZhNJ16HabFAU8L5E9B6QEuarcdJjjCBCr1AkEUIml62OaAKaG6Mc2VDo/KQw3jT2D/th1aP4Rsfnw5nAuyWldPWud0wDkE8W0hCEQ/h4h2zso6GiZobpFUmSUTsDzdEe5PiN0gYwCeNexjtm9hJ1AuhuhvIPuvNRBMayhUQ/+GE22yfQXVvp0nFiNr06c49ZCKJm7nSdfEJu4utl6QGaAOHHTlXAxGNTwlPJclUih7NbiyS+BKguNqD0f4Jr6mlBoemYTmIbJrSwGvjdE5+h3WzMQj4ML0b3KDOGNhyEvN7/jrXuISENs3h9s8Ydz47wbgXxtTWFu/FVuZYIcMCU7J0Z9y1O25qgd6obN+4vhLRrKbgTRT/odsPzL86EzXvxOvzveIiTY6pJZlhPZxsnEw6d6DPskmljms=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d7f86b9-e74c-422b-d765-08db52fadc1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2023 15:09:19.0922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hlQ82aS7xFOvmcp0vJTHsw3yRy0jlzC7BArN6RHLKiIzrR2NcQiSz5mN211z8BPads8quXy+XcdCGysAIyeGIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5761
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_09,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=946 phishscore=0
 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120125
X-Proofpoint-ORIG-GUID: 0C2dDO0tG0AOulo8hUFOIyMAm1aWQRCT
X-Proofpoint-GUID: 0C2dDO0tG0AOulo8hUFOIyMAm1aWQRCT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 12, 2023, at 7:53 AM, Azeem Shaikh <azeemshaikh38@gmail.com> wrote=
:
>=20
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy here.

Let's update the patch description. This change is really
a clean up -- it doesn't address the memory issues you
originally described.


> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcp=
y
> [2] https://github.com/KSPP/linux/issues/89
>=20
> Fixes: 3c92fba557c6 ("NFSD: Enhance the nfsd_cb_setup tracepoint")
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> ---
> v1: https://lore.kernel.org/all/20230510220952.3507366-1-azeemshaikh38@gm=
ail.com/
>=20
> Changes in v2:
> - Use __assign_str instead of strscpy.
> - Added the Fixes tag.
>=20
> fs/nfsd/trace.h |    6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index 4183819ea082..72a906a053dc 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -1365,19 +1365,19 @@ TRACE_EVENT(nfsd_cb_setup,
> __field(u32, cl_id)
> __field(unsigned long, authflavor)
> __sockaddr(addr, clp->cl_cb_conn.cb_addrlen)
> - __array(unsigned char, netid, 8)
> + __string(netid, netid)
> ),
> TP_fast_assign(
> __entry->cl_boot =3D clp->cl_clientid.cl_boot;
> __entry->cl_id =3D clp->cl_clientid.cl_id;
> - strlcpy(__entry->netid, netid, sizeof(__entry->netid));
> + __assign_str(netid, netid);
> __entry->authflavor =3D authflavor;
> __assign_sockaddr(addr, &clp->cl_cb_conn.cb_addr,
>  clp->cl_cb_conn.cb_addrlen)
> ),
> TP_printk("addr=3D%pISpc client %08x:%08x proto=3D%s flavor=3D%s",
> __get_sockaddr(addr), __entry->cl_boot, __entry->cl_id,
> - __entry->netid, show_nfsd_authflavor(__entry->authflavor))
> + __get_str(netid), show_nfsd_authflavor(__entry->authflavor))
> );
>=20
> TRACE_EVENT(nfsd_cb_setup_err,
> --=20
> 2.40.1.606.ga4b1b128d6-goog
>=20
>=20

--
Chuck Lever


