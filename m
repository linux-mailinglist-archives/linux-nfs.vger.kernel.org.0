Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67DE177500A
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Aug 2023 03:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjHIBEo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Aug 2023 21:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjHIBEn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Aug 2023 21:04:43 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7936F19AD
        for <linux-nfs@vger.kernel.org>; Tue,  8 Aug 2023 18:04:43 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 378MiK3d027044;
        Wed, 9 Aug 2023 01:04:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=5FSu2e+dPVujIIkRR35KkMbFBXioht3j8z/4msy+Z70=;
 b=L1EHzEQUxpdA/7N9+UEJxwMzlNDZ4dPRErxWwoj4kWLz8R/lc1Nb+Et9k1ycEYJ39NIy
 c2D9hOuDjPXFnhxHNa5dsGOBP1gW8+wvCCzY2hETZ5wYn8n2ue37fi/51TlaQ5GLWGHo
 rP5s45NRn3EUwyNbHq9nuOs1kqOOtpn2wGYLLnbtJPp0QoDQdv//5zmc0DdjHugqlIIY
 KA4b+kLCHLtSeK7BR3xH06Io37Be43fY0F3ACkyKydS/jn4iGQb45tZOkR84/R72CfpR
 xHn/S9iOBPoPyacOqmx0Qm5OU18a9mIfkab1/Pf0xAoRlrvrIUCynhIpsbhtv9EOIZwO XA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s9eaaq2yy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Aug 2023 01:04:35 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 378N5aHM010669;
        Wed, 9 Aug 2023 01:04:35 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cv6aq4e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Aug 2023 01:04:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R4heA8YvN7xMpCbJX1TIsR3d5olYjjFgAOjBO0E8FIvZLjMr75OI/hDqqYTXOeH7+iO6jRbhNNMNr7EmjQOoJELD1MTmufxHeua47cxN1NiPm3zeS3HjsCmV8QTTFAoqtcBbuvO9wvognKAVQwwt2hfdokWJ6sgNGdDOaWhKoW2R3hsFc+BLALa4ZADBOi+c98l9jYb6S81GCnNbut4xh1CenGw4RGnNrYUzZSByHIXfDlsHm3y6VgdTevdUOIdDyEWVVS+VhOtpZ/D+avRidH4vxqTlkRaFI+82Z4peCjyUSasehK2KWnTRnf4rGzMLV+5a2OcBL+PgPCuZ5NeySw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5FSu2e+dPVujIIkRR35KkMbFBXioht3j8z/4msy+Z70=;
 b=Va6sB0PFo47VenTz4kJhza4ZZnvmLfvWvg+LzCczUGNF6mK0rDpFogqpwtMF+Db7AIo/pZctqomnYn3fjWf4Gm3Bh2Y2nlzMY4wcA/FzG7z+oPjW2KYGHj9ZSDm5l8c6XI4nyP4HW+LrdB/kB+9e3nHu5bOx1+hlGGXknD/uav0k5QBjKAZjM5JJD115oXoORUT46a5s7FpaRwvxX5esYmS99nFY5H2s6CjDuKUaK8kLPUCDbpzJHfSvimmfG8vZal99Mh7mCa6Z7iwewaM/KaT8UbSuSLhGkIun787jTXIMp/dlJ3yNuhdZQkBVjHx0abxPNlLV24EHHameMhKvOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5FSu2e+dPVujIIkRR35KkMbFBXioht3j8z/4msy+Z70=;
 b=jbai/OqhUM2um4fm717LbErEbQRMpbZHQ69XWgzm0R59v110Jq+sS6vKNMS+O5ykRCSZLHcCowfFZvabsIYg5CUAQb4qUkBCr3Zq82MogCfu/Nfl5b7ig08ePOcXJI0keRmZyjlMkOnoihYZV+tUSZF4mAVynMz4U62StJWDIrQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB5116.namprd10.prod.outlook.com (2603:10b6:610:d9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 01:04:32 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 01:04:32 +0000
Date:   Tue, 8 Aug 2023 21:04:29 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        linux-nfs@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: Re: [PATCH] NFSD: add version field to nfsd_rpc_status_show handler
Message-ID: <ZNLmHZ/leArMDsEE@tissot.1015granger.net>
References: <6431d0ea2295a1e128f83cd76a419dee161e4c44.1691482815.git.lorenzo@kernel.org>
 <169149440399.32308.1010201101079709026@noble.neil.brown.name>
 <ZNJCIRjI64YIY+I0@tissot.1015granger.net>
 <ea598236b2da9f1aa9b587ca797afaa9de5545c7.camel@kernel.org>
 <ZNJLQIxweTaEsu16@tissot.1015granger.net>
 <ed02b06f96eeeca4d499583f2bdf31a433921aa1.camel@kernel.org>
 <ZNJctyaMBVuoT6yz@tissot.1015granger.net>
 <169153110624.32308.3596310364486971122@noble.neil.brown.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169153110624.32308.3596310364486971122@noble.neil.brown.name>
X-ClientProxiedBy: CH2PR04CA0024.namprd04.prod.outlook.com
 (2603:10b6:610:52::34) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH0PR10MB5116:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ab75fcb-153c-4a07-c27d-08db9874971e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HnggiJcdF5DXfDBGRZxdjws8LxanaVQ9Xyzvb1EugrKG1fOH8y0glVJcE98UDVjfwKSZe4OHiyDRCcPnI6mgzzYdxykmuV16EOMnOFKdDL5580pEUEuNjviKDNm4O8XKlpNYFrDRb9NL9ZAzrRf2jk4IKnp7L3uV1WfvUHuftpZcBq30TEY7NIqZBnWkw4maYXaEx5LVw3XwkY0XPLv5YAW5ujEYUgZN68wNt4lJUo5BeW9mQA/8uh6kw+3M6MtvklZCZ5vbMfOmjyFIPBCw0p5cfYo1QtJN9Qp0osOzH/4iPLuky1jbZ17hiedFz1fqPRBqAPAB6MKOdJHmBtYxhwMSWX7T0iteDYdZy2dBIxb4/4lB2PlW9bsZZ0526jV1f5OOJZB+j08DeiUYfe5SGH/cZsFso+HjZpBniSc39TdB5Qd0wEFvUQKU0V6WR/8sX4MB9P5P8C+PBMjKD6GkS2sQBYc7L/8lOZZm6KbcXYc/6uYTECRp6vNqpAoxuD54ZWJut7DGayHE51RoDu3ly28YSKB6xkrRPVAlAnMB05225C4wfiyyQqpZ+ZAlPfnd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(346002)(396003)(376002)(366004)(1800799006)(186006)(451199021)(6666004)(54906003)(38100700002)(86362001)(478600001)(66556008)(4326008)(6916009)(66946007)(66476007)(316002)(9686003)(6512007)(6506007)(26005)(6486002)(41300700001)(2906002)(83380400001)(8676002)(44832011)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gN79z3beKh5/oZVaVOklX2mDC/q9rFcQunuTcjXKWtfWBSmPiQSrAK1/95Fp?=
 =?us-ascii?Q?iQlYgxKzPqUygB8ATiz3R9272TNZEmNVusUjQmqJuUgGFlV0b80kfDjWBvf2?=
 =?us-ascii?Q?M3zJoli6vCxRYXjlarHES7KOrC9Q64dZIO5ICQVMjc8P0e3bZrgDLZQmYV3/?=
 =?us-ascii?Q?U2rX97e1vJY9Mw0zIbJtQ/MwKfJ68ruvnDaBrc4xY5F6//4vPvGa4IwAS2Gg?=
 =?us-ascii?Q?B36BmyZ7IzuQg3Z6xwv4qIodkRZdseb7YHTrPa0m65ashyGjHIv8Aqxl+ZRs?=
 =?us-ascii?Q?VtUVrObkCZBpZ5fny7hMlyakeRAwtuDBy8byXZO+3nU1AUJorBXZWipYp9es?=
 =?us-ascii?Q?LXKztQQEfw1b/qBgA2zsyFHeSbDjarih9JqvvokZOfBYQzgWtRBW/EvWCZw2?=
 =?us-ascii?Q?55zpiHftswCh2zln9VY2MBCMFlI3WaO4bMNmY0vljFZypAPHveWLnYl+fbVU?=
 =?us-ascii?Q?dSddxfwed6tX//G0espydJ77PxMyCMxI6FoPknqC/xeYkDq+wxWax6BI3bs6?=
 =?us-ascii?Q?ptfBAULsIKS9iR9Fju91xP2OovTL5nC5UZN8vuDzdCq6Ss6iWwMS2JttSHVV?=
 =?us-ascii?Q?L0QRBGY1sr1G9n6fLIgQhqOK3EwkFDgatoVGXzffn0jpUz3lBaQ+2EQOccph?=
 =?us-ascii?Q?IoP4HistFv17XKaSP2nCMrhfHfs0kLnBUf932lpAn0WS/ExcWFQiUoFInmCb?=
 =?us-ascii?Q?u9DEOx3kzMBPs7S3yfP7fzmXmAEN8hNBrM2lNVlFLpV/rMp486bQG9hWdf9N?=
 =?us-ascii?Q?JxE0OMJ0RnGoVbYqdrc9wnUt9ikrXJJuJ3clUNKGPOZGwM02SzrhsKFK0zzu?=
 =?us-ascii?Q?x6mx3Y1rUWnKvMUd3aWj2vV6eVtTtEBXI3HQz3Hn+IxQ71alOCkd5C8UF472?=
 =?us-ascii?Q?WcZOXEUF/13ipnL5ZkKBHuTSd8vHEiKHlJeY10bqo3zhpXOS8lKalIWpRf+z?=
 =?us-ascii?Q?E2O9bKB4EKamRixbeZqylmNf9/0gDqOHByS3mRlmmqRt6k2ZHbPs9SljKpzY?=
 =?us-ascii?Q?hDZWqF7qpPflZZKcktGRjoV6LQi9DmKnMFrMgQGpiX5jSxXNDBlb2SB5B0ob?=
 =?us-ascii?Q?f5Gi01Tv6MycQgCfx7cPyxNOihVToXWHitP1Isxo0kh1N1qmYeaureW9JY2G?=
 =?us-ascii?Q?RUHwj2dQpWqgkXkcXUHhsAlEsrcAZniiJHI4kxnAlxJyJtw17nyEYGrqUrnS?=
 =?us-ascii?Q?rpnMYDQ9YSmQl960um28XVj60jwMa43K9uZ3qlQkZg0vTle7b0n/SMy1EUu/?=
 =?us-ascii?Q?dUvUPKLqk2R7QAwPngYub7vJ9yhAt7rHqTDxGU75haR8dthhDtI4JJMTMJV2?=
 =?us-ascii?Q?+PyaG9NxUporEhVnYcoNgmXZa5NPiwT/4iFmPAmt1j4Wr9RaG/dwQy013D1p?=
 =?us-ascii?Q?W15/das/BmO9PcfpLyyMhAJFKOnB5lSCO2e7ZTNUvIsvTyadDxubE8WrViTs?=
 =?us-ascii?Q?rqgR1+bioP8QfrZaoPuPEnfujUvwD9JDERezrn86LNP6UP9WZYQkTxoope5d?=
 =?us-ascii?Q?tanDTVzIvhBr+CVat2qx2kq6LRYNlgIKVCw+JbsTlP3Gl0DPiZuNeiOUEWaf?=
 =?us-ascii?Q?eEmkyCeryp2T05LtcgeFjiL9MCuJbCXB6Fm+859t5Mc1Ij/JiU/7Yfg6bCzs?=
 =?us-ascii?Q?Vg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 26EsAlTd2g7OfWDUMZ6R3Rw7mA8nL+QcgGdja0/t4xPWnKTlvr7ajQEOr2ruo0EqWWggQF2vFV8geOG/h3+NvVLHIX3uyZv/af6+6VuERjpnYxAayFds3d40UtmmT2RksNblUkCtOMw55d4jI5eZmfYUbv5jUhA96fnbTfIytL0eagJ4gE1vIpqxrFs6Bc5yVwLQAuojLmAkv2laqjqMo8V5ZX/uYIpDvwQEP6Cn/soLbJkWJQW3WGG+oQSpymwuRiXm6rU3vmbew7ctlaNQe8K0NM+T6L2xEKctv3yTP5OCGdrv5JoNv2GEZqJG0AFY00fy592aV5410EYVVpcPeAlXcVC6nne0TXaI06oEaBl93evQT17fl4b5pISVnqEuSg48Cb6OuOWSVrk1GebRjfy15gC2E+FTOi3aEIvXPPD+3GXpkRWwoLSg9Bt3ceHQtM3OwNdHfya3jpWxBZdC+V8/xWCc6PGxIShSPGRUDswEXF0gN8nw6dhcObR5yk8hB37yIhIOVrYCDezS4BV0M0QO0uYaB+Snv85GQQEcWxWpkLBgVTidNZQoNhl9AaLC/2hGmqLBU+i2RzN+bTExuZae/ivn3ohH5YVnlvJlA3gYTxB4MXKSOe91Nli9t2sOstAaNJSGbzf3Ch5lv/vTM77DSmGI3wZSVZ4/w2xLIUtM/nv93wMkdhe0kgeMdvGqpXLCJEV7laOV/hu3zdoJm7afFuli6fCXIT9q7hgpQn8K2WaI8JXdMcwb1xIMEGPj3pDP++CaI5b6gPPVKkMc44gQTpL4Qrjv8B5ysOtf5dXv/wISZO14aUzW7hjUI2owvEWxOj9uPZCYGCwl9YxbXQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ab75fcb-153c-4a07-c27d-08db9874971e
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 01:04:32.4453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eKJ4EZx/WAUCcOFCMDQOeVHwnBK5wDpoy0TFnfbZpBxoqnBePdUIL40gF+LaSRniGhbk4xRUQmT7VgqrFhYfow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5116
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-08_24,2023-08-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308090008
X-Proofpoint-ORIG-GUID: q1IDZVfqoWJggwYLrtRas2nuPuXW5J88
X-Proofpoint-GUID: q1IDZVfqoWJggwYLrtRas2nuPuXW5J88
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Aug 09, 2023 at 07:45:06AM +1000, NeilBrown wrote:
> On Wed, 09 Aug 2023, Chuck Lever wrote:
> > On Tue, Aug 08, 2023 at 10:20:44AM -0400, Jeff Layton wrote:
> > > 
> > > It would probably be fairly simple to output well-formed yaml instead.
> > > JSON and XML are a bit more of a pain.
> > 
> > If folks don't mind, I would like more structured output like one of
> > these self-documenting formats. (I know I said I didn't care before,
> > but I'm beginning to care now ;-)
> 
> Lustre, which I am somewhat involved with, uses YAML for various things.
> If someone else introduced yaml-producing sysfs files to the kernel
> first, that might make the path for lustre smoother :-)

It worries me that there isn't yet kernel infrastructure for
formating yaml in sysfs files. That broadens the scope of this
work significantly.


> Another option is netlink which lustre is stating to use for
> configuration and stats.  It is a self-describing format.  The code
> looks verbose, but it is widely used in the kernel and so well supported.

I just spent the last 6 months building a netlink upcall to handle
TLS handshake requests for in-kernel TLS consumers. It is built on
the recently-added yaml netlink specs and code generator. The yaml
netlink specs are kept under:

  Documentation/netlink/specs/

Using netlink would give us a lot of infrastructure for this
facility, but I'm not sure it's worth the extra complexity. And it
would /require/ the use of user space tooling (ie, not 'cat') to get
to the information exported from the kernel. <shrug>


> > I'm also wondering if we really ought not add another file under
> > /proc, which is essentially obsolete. Would /sys/fs/nfsd/yada be
> > better for this facility?
> 
> It is only under /proc because that is where it is mounted by default :-)
> I think it might be sensible to create a node under /sys where all the
> content of the nfsd filesystem also appears.

There are things in the nfsd filesystem that really belong under
/proc/net/rpc or elsewhere, so IMO such migration needs to be
handled on a case-by-case basis -- different project for another
time.


> I'm not keen on /sys/fs/nfsd because nfsd isn't a filesystem, it is a
> service.

How about /sys/module/nfsd ?


> > I hesitate to even mention network namespaces...
> 
> Please do mention them - I find them too easy to forget about.
> /proc/fs/nfsd/ inherits the network namespace from whoever mounts it.
> So this can work perfectly.
> If we created a mirror in /sys/ we would presumably use the namespace of
> the process that opens the file.

I agree: the network namespace of the process that opens the
rpc_status file is just what we want to limit access to in-flight
requests. The current network namespace of each thread is available
via SVC_NET(rqst), so it should be quite simple to display only
in-flight requests that match the opener's namespace.


-- 
Chuck Lever
