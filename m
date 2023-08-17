Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E89F7800FC
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Aug 2023 00:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355688AbjHQWY0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Aug 2023 18:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355686AbjHQWYG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Aug 2023 18:24:06 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EEA30C5
        for <linux-nfs@vger.kernel.org>; Thu, 17 Aug 2023 15:24:04 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37HI0nTR021966;
        Thu, 17 Aug 2023 22:23:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=7AzMj58LtxenDzSPn2kqAZs63JhFxKof5bE/RRZIqdo=;
 b=kL/RuVpC69G3gTrRWVnBe8J7u5LTR3I9T313UZ/JCL4JGov78d6sup2mfqQRX3xX0c9m
 JjnTBv68FvT/6whUrcx+9VbCVVghjxkw9Fkq9OboXNG0x5mA8c8namY2cUFCxhR+JX4C
 gcNqTqE+8JIPUn1Rw+YW8z0pSDbnSE9sWYr8BnxSl0kYx67zDmxRiugrdSJKDF9zyPxo
 ctiLBAChPiRd6sg4pl+KvQx/cHb1/aiIHjmSsajPhPGfxJC+n9YxG7RrEhG06V3JorZJ
 wlldONsGPNJkCIDovpNOLJLrqpOm6XspipHjLfjH9wL1UMM/Ey8la2ADEbMPB1nq4zS6 +w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2xwtpqu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Aug 2023 22:23:49 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37HM2iQw003706;
        Thu, 17 Aug 2023 22:23:47 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sexyn7a02-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Aug 2023 22:23:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RIX6AnU/nneuAxIguEfzPtTgcOBLyeDX6cKF7ci26iobflrQeL5ts/79t0jrLW1XTq/2wyryYyJp4mkdrKD7dmz+6gyS++mrGT1FFDTMKPGRl8OCCzzISEC34RosnvChC5JWBoQhvZlAlktwJJjbgbj2PMwL4aZbGEUo5qTUqbyiTg34u/DOCtLZ20VsWAs2hif5EDV289zeAFAyxeNJzPJQJVc5wukIzuW9LvVQ8b8ogvtiJaqGYpQtM/NlxzfbK2LN4uppYhD5hXk9+N+IUphzxy1x6QsGDLDCw2sl3SZ+bmL7DcXum+f6umKOGjSv/A2DcESAvCQzlQkYzg9jhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7AzMj58LtxenDzSPn2kqAZs63JhFxKof5bE/RRZIqdo=;
 b=CbKFA6ZZDXg98E6LhXbIo5miHlOql9Rygc2det8c6PgDFkSiuQo2bgZTUwNgmHpt6NJRDObZ3Xdf1R7KW7yQZXaMfWp8vQezu4xu/g5VKhvZB4+sbvApMQLMpE/UWBWAubpZliD7ONBCXTXNhNPwb0sDnXmq4u9NLpjlFSPAv+huHffcO1fXX34DwVb/Fsyi7Sg18YSg9FUje4dSlS0WfkRKp6I75c65E28g1DXqPuwHleJt0SsOUv3avUE+rZMrdgse42yPieFVq3IXNFpGqqGtg6Ggy0DYAV4J/rjZF0ZeQAhO6HDnSgcVsDHi1Iyb/+NMkwUwFPUk+OUihoUMTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7AzMj58LtxenDzSPn2kqAZs63JhFxKof5bE/RRZIqdo=;
 b=UVcMEoKBADh0r/kwWWv2ixRUxt2q+EPXHXbxWr536IPMVCdc4tHB8SSSw7qUQiAagtbmMLQK5/rY1SFNAINKBdHcLx0twD/CX9moYuR50IuXZ/5/AlNukW2lijUxedtSUjvnASV0sJa6p1OYFYN+ASA4rFS5Oz/FBEVJ5K9EVyk=
Received: from MN2PR10MB4270.namprd10.prod.outlook.com (2603:10b6:208:1d6::21)
 by CYYPR10MB7675.namprd10.prod.outlook.com (2603:10b6:930:b8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Thu, 17 Aug
 2023 22:23:23 +0000
Received: from MN2PR10MB4270.namprd10.prod.outlook.com
 ([fe80::3fd7:973:c9d7:afe2]) by MN2PR10MB4270.namprd10.prod.outlook.com
 ([fe80::3fd7:973:c9d7:afe2%4]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 22:23:23 +0000
Message-ID: <25bc018a-00a7-1634-9535-9d01328264d3@oracle.com>
Date:   Thu, 17 Aug 2023 15:23:14 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: xfstests results over NFS
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trondmy@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Neil Brown <neilb@suse.de>,
        "Kornievskaia, Olga" <Olga.Kornievskaia@netapp.com>,
        Tom Talpey <tom@talpey.com>
References: <9ee56f62652c3d338aff809f70e7941dfc284bf9.camel@kernel.org>
 <7C595ADA-E841-44F7-918A-3A46A55D546B@oracle.com>
 <2fc1f9bf5fdc25acbcabaf4266584f0857bc4b19.camel@kernel.org>
 <CAFX2Jf=gq-U464_SrebSwCMOU+g0Vcx9Us7SPn8JQEoA6s27DQ@mail.gmail.com>
 <77977950a7d6a4539114fdd0d6db982143c4f9b1.camel@kernel.org>
 <0AEF7E06-E2F6-426D-B3DF-3D0ED8233082@oracle.com>
 <6af7807c75e3d6110bc80661a600038f5cfb0022.camel@kernel.org>
 <7b2746692aef1725cb000faabf4db2d115279423.camel@kernel.org>
From:   dai.ngo@oracle.com
In-Reply-To: <7b2746692aef1725cb000faabf4db2d115279423.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7P222CA0026.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::24) To MN2PR10MB4270.namprd10.prod.outlook.com
 (2603:10b6:208:1d6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4270:EE_|CYYPR10MB7675:EE_
X-MS-Office365-Filtering-Correlation-Id: 3be7d481-c23a-4d57-f235-08db9f7091a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k0NJC+mwwzB2qBrDlsGpZRFZ46q4rO/VRIjvgpU8zoLoy424rwmvKE+7dc/lW/veuDCR8+FHe5KBCW4yNVYOE8SOp44X1p/Q3k3kQQQPvgUy1GNGGwrukOVhQgv1WTAvp96SyKf4/Wq9fbENoIqEPrIicMYuhk25fTSmTM2/MQ2zitwcB+PTbY9qFqnCjHJj7Tz1ZWfI75Fh1+kGN7a5NVb3VnFB7NF6QgqobG4oYihsB8hcY0iUzDsPMa2Y5xMX2pyeKRh16Ll+nX1oUovHoggK0nElE23vwgFk4g9dAaiSdTic28x77fS5gnlCdKbT1Q36rSdfvAp73jjRL2o32szimqsgsBn2yX3tOdN3y2SqDB01RbYyXjuq3nO0F2RVkdrzX5xZJ0PNr7yH54xWD0wtGGAVwQmhI90MPLveBlf4D70exbZXM9J1JKTWmAu280WVL47peE5P+iwxatw/SKVGudNufRbmT5rpcpG3ZZTi/oXd1dI2egYcEKHSXoSjF46cdSYPWUWhAixtlb3tMS+N7rRLPPDwzUltiUivMpD+HNCjwBeAgkadNBvFHO6YtK8O30ov8mhXHjieksSzwqHd0BZdx+pV2HWY92YtSBU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4270.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(346002)(376002)(39860400002)(186009)(451199024)(1800799009)(31696002)(2906002)(83380400001)(26005)(86362001)(478600001)(6506007)(6666004)(6486002)(2616005)(36756003)(6512007)(53546011)(9686003)(3480700007)(5660300002)(41300700001)(54906003)(316002)(66946007)(66476007)(66556008)(110136005)(31686004)(8676002)(4326008)(8936002)(38100700002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzRSNWZueTZsWXpaTTZRSzArL3pVejVGZE9XeXRDNmwzT2loRGZtakkyTjBO?=
 =?utf-8?B?S1BNTXhHekRkUVgzR0hLOS9tMWh4NmFSSG5QakN1cnpjcTdNa0U1eDlsdDh3?=
 =?utf-8?B?dzM2OWNoZ3RZWmJKYjFGdGZOQllQck9IMlZxOWNzNGhFQVZpMTR0enpVb2dH?=
 =?utf-8?B?cm1EbzMwNXk0bnIzeFNSMUx2MDZPZXFyd0ZIbFVGUHNIcnM5WnRwUlVvMVFE?=
 =?utf-8?B?UnJidWtudW4wL1hvZHREN09WaUtRUm92UGY2c1g2UkVTR2JxNG9sbVp6c1dH?=
 =?utf-8?B?UHBuV3ZMc1ZDVFVhQnlERUc2bTVyZFVkVFoxelNEcitodGxDWjdOZ3JhbjVm?=
 =?utf-8?B?WDFWR3EvUGd0dm1xaHNqaXNDcFd6YTg5cWJQMVl2K2VPVGFMbmYwcnlyZitz?=
 =?utf-8?B?TFFhTHZXaU9LVk9tZWtuSWRISmlEbUNHbXhVK3RWU3ZkSE9ybjZRUGRxN0h3?=
 =?utf-8?B?N1dxcE5PSXlNdndaQlNUcXQ2QmlqU1gzdXU2QmpmT05JeHh3bUhOSElIUkZ6?=
 =?utf-8?B?amRZaFpIZ2tJcEwrT3AyQWtEbGpmN3liUVp2dGhBZmVDSUEzeHRBbFpMMkNV?=
 =?utf-8?B?T1ZGZ0dpeElzWkdobU02cDdidzE3VjNkVS9vRVozVlAxcmdDTkE3b1NXSG9D?=
 =?utf-8?B?YTI5Nk1KeFRXTHlKSDJFR2E2ZHVwZmV5Q3VGNThrcFhMNEFJSFFJK0FweVNX?=
 =?utf-8?B?b0Y1U1FkOG9kWGhJWTEyaE4wb2VmZEFBNG5GK3BvOWswbUF4TDhIUGVKb0Mr?=
 =?utf-8?B?NkZ5eDJHOFFQY29rczBraFBQS29lRE5adlZBZjZnNmE2Y0MrSVFxR0lsWGpU?=
 =?utf-8?B?OVYrOFdSb1QxNktkQ1FsU0h6RUxuWWdZYTdMWEloc2xSbCsrK0FEU2RVbmtu?=
 =?utf-8?B?SEtvdDJjOUhSWFpIeG5aZkZwSWd5VUtnYTFSdWRvWFBpR1BLaVBvUG1hZ0g5?=
 =?utf-8?B?Ui9QM2lwZkdid01VVHZhcWpQR2JuUjB3ZWF0Z3o5T3pINWo4bSsrb1FVUWhG?=
 =?utf-8?B?bGV3LzJ2OFFEd1YyTkx5QTZyQm10ZXFpeFB2R1pyYW44VEhGYWFpcmFaL1V1?=
 =?utf-8?B?aTEvTUN0OUtKTDViRHI5KzdrS0FkQlpoQWZaOE5Od25pd3FES0NXeVJaeC83?=
 =?utf-8?B?S3JVenJQWFcwNXo5emZ4bEUyQWZ6MXk0V21QTmZIeDNhNmNjY0xrWUFTanor?=
 =?utf-8?B?Q0tPOVdMUURsYXd0M3VVVFJPVFRJbG9adk8xdDlxaXl2akZGVEZyOXNucWxj?=
 =?utf-8?B?Nmw3ZitSdTdlSHhMNkRSVlFVbW1jYkNtRTk5cjVNNGowcUdNTkVQQldneHh0?=
 =?utf-8?B?aVNWT0JEcUw1cUdHc2lxZmVkN1pBSDVzNDY1TGRNUUN4VzdxR1B4V25QY1Jo?=
 =?utf-8?B?ajNHVW5VK01hTjhQNkh4VG4yMEdaazR6WmUxN2VFS2VxWDZra3A3Y3F4aUxH?=
 =?utf-8?B?SGlLRmUvaTdtRVZKNHpLSFpDdkp6V2x4SGJQSVZkdnQzc2dLL0pUR1ZrREVk?=
 =?utf-8?B?SHBTNmhXeng4NGlkV1VuWFdpdnJEZ2E2VHhnTTFhUzUvWDZUS3FZeUo5eXBL?=
 =?utf-8?B?TnlkS0M4V1ErcnVucVYwdU1TRWVIeXQ0YVJaelNLdEg3bHdZcVcwOUc1QlVp?=
 =?utf-8?B?dktGb3l3OXZxem9YZ2VETVRyaktNYVRLN04ydG1SY3Bac1dOQXhrQXdTaEdE?=
 =?utf-8?B?Ui9wZlFqaDZxK0NaWmhyR1BaZTh5UkpyQjZHekpaMUpwVTF1SHNpcGYvZzJ4?=
 =?utf-8?B?UnpVTEFtSU9rWHlKYlZoQS9Za2lqSG90ZjB3MnZ6YVRsYXRWVVQxSkhCb256?=
 =?utf-8?B?NmRMR2IrTXdUTVBFYXdnQjZqSGx1VWF6NkJQK3Fjc1JxclB4d0tNYitvWU1p?=
 =?utf-8?B?OThBUlVNRU56ODk2YlUzazhlZzhqRm1qSTdrdHBOV0FNU2k0Yit4SmZtWFhI?=
 =?utf-8?B?SDg4RWVOelFyQWUvOVdwR1dmNTJybjdpQTVuOGVBTjBDd1dHajZlMmREMjZ2?=
 =?utf-8?B?Y1lOK0tGUXZXSGtXdHV0YXNBc25Obk5RZE9EYzU5RHA4dmk0V2tIY2d2ZWIr?=
 =?utf-8?B?MEgyM0liejh2ckxGbDBGR0VwMkFjT0Jid0s5SW5YaWdVTGR1Tk1LQlJ5dndI?=
 =?utf-8?Q?nwPvaTg8wNB9bSDrsnkhXhNeE?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: asXnHEb0l5jaDoa1MwTjGwpwOkfi8jfas5f+O0X1u7WBS47gkrXNhdelqh3JhC3U2BxYdgdW91UvUy/EMEeXc+EkVHKdagjsA7GB0fTlZfQ6NHm6rfeLSO2N3ls4x0nrcjd1LWogMXIP1v2dg2j+e+4J7rz7QNSlCZd9fXtUVckyzjjyahRquCkgSkx2iVi6aItIGSxehyTr2SRi9p3cVc7OO89q2LcFy/ShWQrkIeXKRffh65KGjCiq9qn5ZqpX6UBVQY0VSlM/j4WZaI+H/tKp8ygoFfn7OjEattKVJdVF9PhXovMnYYN7I5XCxSS0Fkcji3V3Knk6Z/1ra0vbx60I+n9Ulb4iGdWp5d8lDkI739y6UdmEpgDZJul/iSz1N/iAflnEPp9dT5AFwTP0EjuMAfBUJKi9YbcDLfjwMGz0Gp+0nUcEIQBR/Bh8rEoGmsCBAGbcO0raU0Q9sjE8VdHem9kGvlZ3wxZgfaBt1kmRKB8SB7R0cSk8BQIK6svgLY0bTlx+x14vJoIO2HiqNzuEKvPOY697sqWU815x1n6EuWY9Vu65kHztR/b5mP9wO0MiIFCK60++ZKYLFaBzeXcePtQUsYLVKFwf/6E3ZoiMRqHn2gggTAwef1D1GyGiQazCvoaKjhmbxbbbEFWRwJLdrCYh9sQ0Yxz4cH+gmQgGeUICIW4pXZsamJIchXD19LR/Yg22V4tjdi4rc+OReJ/EL5Abn7qypdaP4z4379fqtkqI7+UGLdlcMr1qbQ/zPdcNdElCRr10sk+D519/EP0npE+8/2o0Ec2V6b3YYAfdLr4w2uBswc/g0qNW80mO1+/+ZjIqoX6NwnxwChviLMXY5fnTeIDIaxXv6JPl3MS2hP+1lwa/a672uNG9va/wTnRuggCxNyKpD6u712vguQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3be7d481-c23a-4d57-f235-08db9f7091a3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4270.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 22:23:23.4421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VmlyTyUwVq+pi/af78DWh+OpiZdMR7oR3t1JhOhi/ZtMb8mltHL/bdQd7UdBis2TUCznPpTvDymmqHFPapBdPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7675
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-17_18,2023-08-17_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308170199
X-Proofpoint-ORIG-GUID: X54SSGlcGGndit82v32TnD8yL54_ay-0
X-Proofpoint-GUID: X54SSGlcGGndit82v32TnD8yL54_ay-0
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 8/17/23 2:07 PM, Jeff Layton wrote:
> On Thu, 2023-08-17 at 13:15 -0400, Jeff Layton wrote:
>> On Thu, 2023-08-17 at 16:31 +0000, Chuck Lever III wrote:
>>>> On Aug 17, 2023, at 12:27 PM, Jeff Layton <jlayton@kernel.org> wrote:
>>>>
>>>> On Thu, 2023-08-17 at 11:17 -0400, Anna Schumaker wrote:
>>>>> On Thu, Aug 17, 2023 at 10:22 AM Jeff Layton <jlayton@kernel.org> wrote:
>>>>>> On Thu, 2023-08-17 at 14:04 +0000, Chuck Lever III wrote:
>>>>>>>> On Aug 17, 2023, at 7:21 AM, Jeff Layton <jlayton@kernel.org> wrote:
>>>>>>>>
>>>>>>>> I finally got my kdevops (https://github.com/linux-kdevops/kdevops) test
>>>>>>>> rig working well enough to get some publishable results. To run fstests,
>>>>>>>> kdevops will spin up a server and (in this case) 2 clients to run
>>>>>>>> xfstests' auto group. One client mounts with default options, and the
>>>>>>>> other uses NFSv3.
>>>>>>>>
>>>>>>>> I tested 3 kernels:
>>>>>>>>
>>>>>>>> v6.4.0 (stock release)
>>>>>>>> 6.5.0-rc6-g4853c74bd7ab (Linus' tree as of a couple of days ago)
>>>>>>>> 6.5.0-rc6-next-20230816-gef66bf8aeb91 (linux-next as of yesterday morning)
>>>>>>>>
>>>>>>>> Here are the results summary of all 3:
>>>>>>>>
>>>>>>>> KERNEL:    6.4.0
>>>>>>>> CPUS:      8
>>>>>>>>
>>>>>>>> nfs_v3: 727 tests, 12 failures, 569 skipped, 14863 seconds
>>>>>>>> Failures: generic/053 generic/099 generic/105 generic/124
>>>>>>>>    generic/193 generic/258 generic/294 generic/318 generic/319
>>>>>>>>    generic/444 generic/528 generic/529
>>>>>>>> nfs_default: 727 tests, 18 failures, 452 skipped, 21899 seconds
>>>>>>>> Failures: generic/053 generic/099 generic/105 generic/186
>>>>>>>>    generic/187 generic/193 generic/294 generic/318 generic/319
>>>>>>>>    generic/357 generic/444 generic/486 generic/513 generic/528
>>>>>>>>    generic/529 generic/578 generic/675 generic/688
>>>>>>>> Totals: 1454 tests, 1021 skipped, 30 failures, 0 errors, 35096s
>>>>>>>>
>>>>>>>> KERNEL:    6.5.0-rc6-g4853c74bd7ab
>>>>>>>> CPUS:      8
>>>>>>>>
>>>>>>>> nfs_v3: 727 tests, 9 failures, 570 skipped, 14775 seconds
>>>>>>>> Failures: generic/053 generic/099 generic/105 generic/258
>>>>>>>>    generic/294 generic/318 generic/319 generic/444 generic/529
>>>>>>>> nfs_default: 727 tests, 16 failures, 453 skipped, 22326 seconds
>>>>>>>> Failures: generic/053 generic/099 generic/105 generic/186
>>>>>>>>    generic/187 generic/294 generic/318 generic/319 generic/357
>>>>>>>>    generic/444 generic/486 generic/513 generic/529 generic/578
>>>>>>>>    generic/675 generic/688
>>>>>>>> Totals: 1454 tests, 1023 skipped, 25 failures, 0 errors, 35396s
>>>>>>>>
>>>>>>>> KERNEL:    6.5.0-rc6-next-20230816-gef66bf8aeb91
>>>>>>>> CPUS:      8
>>>>>>>>
>>>>>>>> nfs_v3: 727 tests, 9 failures, 570 skipped, 14657 seconds
>>>>>>>> Failures: generic/053 generic/099 generic/105 generic/258
>>>>>>>>    generic/294 generic/318 generic/319 generic/444 generic/529
>>>>>>>> nfs_default: 727 tests, 18 failures, 453 skipped, 21757 seconds
>>>>>>>> Failures: generic/053 generic/099 generic/105 generic/186
>>>>>>>>    generic/187 generic/294 generic/318 generic/319 generic/357
>>>>>>>>    generic/444 generic/486 generic/513 generic/529 generic/578
>>>>>>>>    generic/675 generic/683 generic/684 generic/688
>>>>>>>> Totals: 1454 tests, 1023 skipped, 27 failures, 0 errors, 34870s
>>>>> As long as we're sharing results ... here is what I'm seeing with a
>>>>> 6.5-rc6 client & server:
>>>>>
>>>>> anna@gouda ~ % xfstestsdb xunit list --results --runid 1741 --color=none
>>>>> +------+----------------------+---------+----------+------+------+------+-------+
>>>>>> run | device               | xunit   | hostname | pass | fail |
>>>>> skip |  time |
>>>>> +------+----------------------+---------+----------+------+------+------+-------+
>>>>>> 1741 | server:/srv/xfs/test | tcp-3   | client   |  125 |    4 |
>>>>> 464 | 447 s |
>>>>>> 1741 | server:/srv/xfs/test | tcp-4.0 | client   |  117 |   11 |
>>>>> 465 | 478 s |
>>>>>> 1741 | server:/srv/xfs/test | tcp-4.1 | client   |  119 |   12 |
>>>>> 462 | 404 s |
>>>>>> 1741 | server:/srv/xfs/test | tcp-4.2 | client   |  212 |   18 |
>>>>> 363 | 564 s |
>>>>> +------+----------------------+---------+----------+------+------+------+-------+
>>>>>
>>>>> anna@gouda ~ % xfstestsdb show --failure 1741 --color=none
>>>>> +-------------+---------+---------+---------+---------+
>>>>>>    testcase | tcp-3   | tcp-4.0 | tcp-4.1 | tcp-4.2 |
>>>>> +-------------+---------+---------+---------+---------+
>>>>>> generic/053 | passed  | failure | failure | failure |
>>>>>> generic/099 | passed  | failure | failure | failure |
>>>>>> generic/105 | passed  | failure | failure | failure |
>>>>>> generic/140 | skipped | skipped | skipped | failure |
>>>>>> generic/188 | skipped | skipped | skipped | failure |
>>>>>> generic/258 | failure | passed  | passed  | failure |
>>>>>> generic/294 | failure | failure | failure | failure |
>>>>>> generic/318 | passed  | failure | failure | failure |
>>>>>> generic/319 | passed  | failure | failure | failure |
>>>>>> generic/357 | skipped | skipped | skipped | failure |
>>>>>> generic/444 | failure | failure | failure | failure |
>>>>>> generic/465 | passed  | failure | failure | failure |
>>>>>> generic/513 | skipped | skipped | skipped | failure |
>>>>>> generic/529 | passed  | failure | failure | failure |
>>>>>> generic/604 | passed  | passed  | failure | passed  |
>>>>>> generic/675 | skipped | skipped | skipped | failure |
>>>>>> generic/688 | skipped | skipped | skipped | failure |
>>>>>> generic/697 | passed  | failure | failure | failure |
>>>>>>     nfs/002 | failure | failure | failure | failure |
>>>>> +-------------+---------+---------+---------+---------+
>>>>>
>>>>>
>>>>>>>> With NFSv4.2, v6.4.0 has 2 extra failures that the current mainline
>>>>>>>> kernel doesn't:
>>>>>>>>
>>>>>>>>    generic/193 (some sort of setattr problem)
>>>>>>>>    generic/528 (known problem with btime handling in client that has been fixed)
>>>>>>>>
>>>>>>>> While I haven't investigated, I'm assuming the 193 bug is also something
>>>>>>>> that has been fixed in recent kernels. There are also 3 other NFSv3
>>>>>>>> tests that started passing since v6.4.0. I haven't looked into those.
>>>>>>>>
>>>>>>>> With the linux-next kernel there are 2 new regressions:
>>>>>>>>
>>>>>>>>    generic/683
>>>>>>>>    generic/684
>>>>>>>>
>>>>>>>> Both of these look like problems with setuid/setgid stripping, and still
>>>>>>>> need to be investigated. I have more verbose result info on the test
>>>>>>>> failures if anyone is interested.
>>>>> Interesting that I'm not seeing the 683 & 684 failures. What type of
>>>>> filesystem is your server exporting?
>>>>>
>>>> btrfs
>>>>
>>>> You are testing linux-next? I need to go back and confirm these results
>>>> too.
>>> IMO linux-next is quite important : we keep hitting bugs that
>>> appear only after integration -- block and network changes in
>>> other trees especially can impact the NFS drivers.
>>>
>> Indeed, I suspect this is probably something from the vfs tree (though
>> we definitely need to confirm that). Today I'm testing:
>>
>>      6.5.0-rc6-next-20230817-g47762f086974
>>
> Nope, I was wrong. I ran a bisect and it landed here. I confirmed it by
> turning off leases on the nfs server and the test started passing. I
> probably won't have the cycles to chase this down further.
>
> The capture looks something like this:
>
> OPEN (get a write delegation
> WRITE
> CLOSE
> SETATTR (mode 06666)
>
> ...then presumably a task on the client opens the file again, but the
> setuid bits don't get stripped.
>
> I think either the client will need to strip these bits on a delegated
> open, or we'll need to recall write delegations from the client when it
> tries to do a SETATTR with a mode that could later end up needing to be
> stripped on a subsequent open:
>
> 66ce3e3b98a7a9e970ea463a7f7dc0575c0a244b is the first bad commit
> commit 66ce3e3b98a7a9e970ea463a7f7dc0575c0a244b
> Author: Dai Ngo <dai.ngo@oracle.com>
> Date:   Thu Jun 29 18:52:40 2023 -0700
>
>      NFSD: Enable write delegation support

The SETATTR should cause the delegation to be recalled. However, I think
there is an optimization on server that skips the recall if the SETATTR
comes from the same client that has the delegation.

I'll take a look.

Thanks,
-Dai

>
