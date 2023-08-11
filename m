Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6749779164
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Aug 2023 16:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjHKOHu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Aug 2023 10:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjHKOHu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 11 Aug 2023 10:07:50 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB14E65
        for <linux-nfs@vger.kernel.org>; Fri, 11 Aug 2023 07:07:49 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37BDcHnI002201;
        Fri, 11 Aug 2023 14:07:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=lt1/IOMsdRqRN0G6I6vnH1GPyf7TV2Wa/qOK5JCElXU=;
 b=CyG7VDgj4+ChqvOn++ol7rbeYs8AF4bS2TBXEu2Xer4crGLASBRC6ShZ+wEyI+Y4Wt82
 hQ3F8DZdAoF22pYJ2WdrsHiJg6zvTBQv8q+FCKlLpO2Qc75V5Xbi9FLy2WMFNo4NwhHu
 jy6bnsIHXsvvjYQDqP7ApncWSE0IjL/R0IS8qgjsfqL1VWmbMkMDBvtqndNDzlF2qGlM
 oKNSKV4YlJqkIf+Zy3Zjh7mKDG4q575I0oBJCNXqq+Yw5tx84raKsvO1GVvzVwu1BRKc
 ueMNwkkEZ3vHfiKu9RaHu5++HD/WgvkpnHJjWAyXXNkaPflSf7UWSa1TqdNIJfpMffay Uw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sd8ych3f1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Aug 2023 14:07:25 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37BCdht4012039;
        Fri, 11 Aug 2023 14:07:24 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cv9v71x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Aug 2023 14:07:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SUZ1S71H4CSFSqxKAfK9j5/nzIPmrCIf6mATNuuzzXxPnhOlwPtcgDD3qCBZYxGwJR2tQ3WiufsqjpHiFfcZHh2hxXk3DIH4cuqxCBLSodM5DcQizBjTRAWENjAGKUQQuF5HHRsWRwTIsHUHh4h3qzJnVOWVzLWsD29gNCE+JN6fakbgWLvsgsK+BA0g1I/F5R0A89scAEVs/h/GLPyW97B5SZuNlrXzrJlgjIPK4i+t1n4lxOZvlkqaCfXZxPjz5Y0wRVPNcrWT345MQeiAoFAb5z3p8t2YlSNg8rBPddQQXoCQY+iVUfsigBaTIn/Q24D3AmNN/fSaMwEvAFnAQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lt1/IOMsdRqRN0G6I6vnH1GPyf7TV2Wa/qOK5JCElXU=;
 b=gqoSMB2PR9bP8mD1LJQEWWr77LLjHWFNr1NVGg9vEoXkW7FnXskXHcJUAP4cRTCRBieF5MdAFM5IMo5xLURpFi+rZkfbZlM711NOtc9igmEdMoX1NADIavsE0DYmwloHZEeYL9ao3HPORESwix8sU9+NSYY1OdCjd17JHOqSYt9BQdKypK3kvnldmcHxjENnZx9+M2QIUcN8VUqoPzLdmMWUa1aYNbLwXIpeeXcM8mreil0k4GI+DlPNWz3GjUT1Ky8iRAWTez3i3Z3tPm6uJGusl2FGZ1mkoVsN5fLSsThSquG1MrNthE+P7gOO4ma+Q8BvavBFc0haQGQ7NRdFHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lt1/IOMsdRqRN0G6I6vnH1GPyf7TV2Wa/qOK5JCElXU=;
 b=I9IS5vFqHglmxwXXdPpkz8JOeB7Vy/RguSTk3oTtFWJDvvgkB142JChoCQAG5nsZbH1xQg3WtfWiukSo8gJSNdZw+33xX3GiQtDAnJASrhvwVOJRd7euBJAGCt7Cm1Cq+a3/1sMLtii91QsNZg9avxN1CgDf1M0/jjuJTtGLBPw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH8PR10MB6550.namprd10.prod.outlook.com (2603:10b6:510:226::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 14:07:21 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6678.019; Fri, 11 Aug 2023
 14:07:21 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>, Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v6 3/3] NFSD: add rpc_status entry in nfsd debug
 filesystem
Thread-Topic: [PATCH v6 3/3] NFSD: add rpc_status entry in nfsd debug
 filesystem
Thread-Index: AQHZy2ZFk8tcJXUTiE2sgxvjOkAuPK/joD+AgABaVICAASjegA==
Date:   Fri, 11 Aug 2023 14:07:21 +0000
Message-ID: <2D7CA2D5-EE53-412E-9F64-DB88B4938475@oracle.com>
References: <cover.1691656474.git.lorenzo@kernel.org>
 <177cfd4fc640d9b406101761be24da07990ca81e.1691656474.git.lorenzo@kernel.org>
 <ZNT7wdG8SYfDRkDg@tissot.1015granger.net>
 <169169907976.11073.6029761322750936330@noble.neil.brown.name>
In-Reply-To: <169169907976.11073.6029761322750936330@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH8PR10MB6550:EE_
x-ms-office365-filtering-correlation-id: 7f4bd375-db3c-4139-c5d5-08db9a7447d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IQzCWePt6VlrXDB2H1b0KFi3Nd6ui47d7gYuA7maTCeGCH0AD+1zd61+Kt4PKLF+1Zxhi/H144ZVJOsuclQ+hcyaupMLG1i88htMs9roKgmNQbrrfDRMdbVrvZ/34zSbS6bAQAMTqxD/kXBlvrfuUBypZRvnL3rssEIQlk1TKYX8I6thOKAxqUD42nAZg8gaNSuIGmF+8SEblhFrQuGpzFc554rwNVuPPKM0dl9kdg6WUqt5a0nkzfRBfunVaQ/sI5PDDP9clfya7ZTNo4m1DDFLzIpUeRP2x7Pn8bEHUMrxfw0Pp1Ig6/li47g/vUq8mlproEThHFwGsnp4fOTqndvrlwElshKOQTpDDBicMxPxT7QjeLtd3YQGPiyqLOBQDpLvzYEWW/15FUrsQsDzMMc9ArG/anutZehgIQZqk5vVRjpeO/MgHO8B1z5EBVcNRc+Caw6K/Z5RIR+LLiP1hGK3unhdnubnG7u3/eOh+qUfr7T2wA393G/RsJVPhfzlPeIo6qHN6BNJNCmjGmCMT/tC/V053YUoNS+ZqudQTfrXFiWL0mQav5JTv829u2HkwMVnj7aZHnlw+wFWa/2pIccccqQAmoazH4+aL3PF+xLl8uTxcsXSH8zX6Vqtgz3bQRA5pj5gF0P/bIV3aG3JOQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(39860400002)(136003)(376002)(346002)(186006)(451199021)(1800799006)(8676002)(966005)(6512007)(8936002)(30864003)(71200400001)(33656002)(478600001)(316002)(2906002)(6486002)(54906003)(38070700005)(110136005)(38100700002)(122000001)(86362001)(6506007)(53546011)(26005)(64756008)(4326008)(66446008)(41300700001)(66476007)(36756003)(76116006)(66556008)(66946007)(2616005)(91956017)(5660300002)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IpZUKvC5ZUD/CZUavrJs3Mz8daLiIuRtUNX6I8rNTMc/wZimr6aBQUk3jAxN?=
 =?us-ascii?Q?DrgEusX1rAvC4mwCL1QQEWcR5N6xHM0meQt/SwajO6MWBfXaQJcmVF9Xt252?=
 =?us-ascii?Q?ji8lXWisH0lpGldOKLapjEbvuO/CQpuu+jIDZk2iGw1rk5ycofMUyEUkAo8X?=
 =?us-ascii?Q?eqq4WEtcLFZEAPuNe5QpqyhpHdThcAvl/a3LTgEBNOP/mzPwgpWr/tkcTQ7J?=
 =?us-ascii?Q?Gyx1YhRHJpQF+zpGYXXQQDTZpkJ8QLM7h+GVoprexiUPZCVQFQEzEDXqxxFJ?=
 =?us-ascii?Q?D2heZweuVrzM/IhFH1JKO/Ci/+7+ojCu1ZfUtA+8c7TiMqZrPF9C+sPDLyCV?=
 =?us-ascii?Q?gpeZYpHoylbtFaxtkrfKxqM9mrsdqN8pA53NkFLlEogYLZ0lOg+biEvgytLt?=
 =?us-ascii?Q?a85xcPjRMWR09saVr0lS2zPX20j7JiQbllunCgQZRDLGUyI89MxdR18gGWvS?=
 =?us-ascii?Q?1SGSKjdireGvRr7AnH7/Sn7dpDbBUpwx5SXdCQLWjPJ6lT4Q9zVg/4zLFI2K?=
 =?us-ascii?Q?51KnTsTpWM5SjmuBwnXWFFEhUX2aSezALxTWTIlqAmBfIKRVqhCL/RpqyOig?=
 =?us-ascii?Q?vIVE1Vdljc4XOFueFELZ0gq66eQtpGZ17Y4vETdJNxcyp550v6Ow0DRHxnyR?=
 =?us-ascii?Q?/t6P33zWZKi/hWtFJ3ry+nnYpj0Vqx7j5gSgXg8LFeYV7O3wQStj7UKJAtCc?=
 =?us-ascii?Q?KaoYWjP3E8TGpB1De8oqw1tWiGW7VLlk4/dwjq6GE7imY9L4E3XaYfFvSAH+?=
 =?us-ascii?Q?z/w5RKEbwOs672jUhE7Xbre7+LqIgjSTcOfGlByhNnNfSJA1XfKoq6fhGuDM?=
 =?us-ascii?Q?AB4gC/T1G3ayuOh2n9QeHpZhSVBBkd9/w/Q/rRAgjzlEKhNG16bmlC5YKwW4?=
 =?us-ascii?Q?Runz0fyR8Yfgp857v72THxlmupbPRWP+4uVb/TkMQ5kiKHVeBRc17v53AKGj?=
 =?us-ascii?Q?kK6ZZQsgrmUgehNEbvXUPqpktV6S6vf7PN63wgfwShJ+wdWTkSh3hnTAQn39?=
 =?us-ascii?Q?YvRqdK/xtknmojbcTub1F8G5pz9whlfFbMxJ9vRDNXCgaVVU7g3nZ4Rk3m36?=
 =?us-ascii?Q?fpgDw44MBUkav6pBos8xeFfBpgVBgKUaAfehQck+6srCokzLWnxP/zxXV2Wv?=
 =?us-ascii?Q?55WvhsjzMvYMRjBFKoxtyXbBTDUhMQA8JfP8aAOe5m+Whyl923oqC69zjczH?=
 =?us-ascii?Q?/Lw3dudAsE2PKbNZ4hFLgQhZn7K9cz1TxkRdRLx0wirlyNFdXMFFuv4BB350?=
 =?us-ascii?Q?vkAtXsSPJwtY0iNk4qvnkk+D7zFu5Df/Dz03VLASJ7g0+iRtxPyzS843Xamf?=
 =?us-ascii?Q?CfEfSq2Jm561uVBzmDpS4FMfWwbL/P01YfzvomjGalkGb10eq3JzBS96OIJg?=
 =?us-ascii?Q?AJL3S379J+ZgTLwoogU7WvdgP/2jsT3n8b1SIQCG+nYz5RHn5daSvLINxpBX?=
 =?us-ascii?Q?dDUyqkZeSt/GjLZQZCKruviZs5A2YHZXg9npoU5I1PadQSae2kSViDXI9fUR?=
 =?us-ascii?Q?Y2tr6yXaHQzR8r9LY3FpR2BOO909240VR3WDcJ1ERy6v4k+NSOjDo/NBzjWV?=
 =?us-ascii?Q?rsTmWyYTpf0li58/4BIHhmbWqpA1IAF46/VDf5QFAZIA5SX81B9fvmMQQj0P?=
 =?us-ascii?Q?jQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F965CB2A41FC164F8F2937657D9781F8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: GvhZbb2pT7XXuECXhoEICfVar7sHQanp9Lf7yP/74v1GX78Uc61Bm6732oZ5MwHxlFVwGW6WXbQg9GqtMddviZYGwsLfsybVL7g8vhLzXgi1+WZs/zrqfjujvbFQJI4qQZW7oNypB6U9pxjLMvSCcRmmR2QPVSvz+mB8otO8PZWhBUA+PV1v5cvtYfKGwfWqLMLh9ZNNSCl/cGn560tr3cHk02W/8RlsVtcE21h3as2GWFDpoRfOeXweXLuoe+SzM9U3TKbn20wE9FDWmM+mwMucrfsZIvUx5J6N62w/omv1HlEYMUGwOQ3Vq5/MLSM3Uo6nkCXw0hk1jDqXitQnbJPn3uxLbSpiU8qgxX6R4zgZNdg25ra6AHun5rjzNHbFFp7Erd0bQ1k6wS8oNGTBZzdfd7YburKCv9KWDE7j/wZ39NIIE7zFHE+V1S82dy6chbNGXnefmtTLCJYaPCjTpVeh00DUNGd4cZMBoXck3YwOv6Xl57+vZwiK2ybbLz329xigWbzX3qg+DOqpberiDuaeMAhSDI9mYih13b8jX859Q0NTnL6jN9vYHyg1iXjn+kpuCecxx1rP3lKBLf0SjGqilJU1+aQd3zZL/Rf0lX+JTwgN6n5lqLXFIgU3u/7cqPH8AW3CZJvpzFH/X18dk2mxAK7uONIOORbFk+susThJ/7rO8fK0BrYZ4J+BxYu6ScsHTgx4Ink18r13k7Afhxet8YDJLTVwvQAxlXm1nZ32o8/K/ttNqcKtawS9IFmmdaXXReHPCrYPw1sqyqC8mYO4yBfW1sS+OpyUjr4mGBpxPGZEj6z4k/CV7ACIOS9+WX73Lr8Jz3fhWT0tdbTWFg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f4bd375-db3c-4139-c5d5-08db9a7447d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2023 14:07:21.4646
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xoQ+u3w+m37idmByDdmy9T/Eo8ab0Uid/kGp76PumIJt2Z/R2kM6A+ZnZKsVbJq8tb44RFW+PzbBwhliPEy1YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6550
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-11_06,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308110129
X-Proofpoint-GUID: ZBUelnbX_0v_8USPC33ZscKA8HP4bOR7
X-Proofpoint-ORIG-GUID: ZBUelnbX_0v_8USPC33ZscKA8HP4bOR7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 10, 2023, at 4:24 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Fri, 11 Aug 2023, Chuck Lever wrote:
>> On Thu, Aug 10, 2023 at 10:39:21AM +0200, Lorenzo Bianconi wrote:
>>> Introduce rpc_status entry in nfsd debug filesystem in order to dump
>>> pending RPC requests debugging information.
>>>=20
>>> Link: https://bugzilla.linux-nfs.org/show_bug.cgi?id=3D366
>>> Reviewed-by: NeilBrown <neilb@suse.de>
>>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>>> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>>> ---
>>> fs/nfsd/nfs4proc.c         |   4 +-
>>> fs/nfsd/nfsctl.c           |   9 +++
>>> fs/nfsd/nfsd.h             |   7 ++
>>> fs/nfsd/nfssvc.c           | 140 +++++++++++++++++++++++++++++++++++++
>>> include/linux/sunrpc/svc.h |   1 +
>>> net/sunrpc/svc.c           |   2 +-
>>> 6 files changed, 159 insertions(+), 4 deletions(-)
>>>=20
>>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>>> index aa4f21f92deb..ff5a1dddc0ed 100644
>>> --- a/fs/nfsd/nfs4proc.c
>>> +++ b/fs/nfsd/nfs4proc.c
>>> @@ -2496,8 +2496,6 @@ static inline void nfsd4_increment_op_stats(u32 o=
pnum)
>>>=20
>>> static const struct nfsd4_operation nfsd4_ops[];
>>>=20
>>> -static const char *nfsd4_op_name(unsigned opnum);
>>> -
>>> /*
>>>  * Enforce NFSv4.1 COMPOUND ordering rules:
>>>  *
>>> @@ -3627,7 +3625,7 @@ void warn_on_nonidempotent_op(struct nfsd4_op *op=
)
>>> }
>>> }
>>>=20
>>> -static const char *nfsd4_op_name(unsigned opnum)
>>> +const char *nfsd4_op_name(unsigned int opnum)
>>> {
>>> if (opnum < ARRAY_SIZE(nfsd4_ops))
>>> return nfsd4_ops[opnum].op_name;
>>> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
>>> index dad88bff3b9e..83eb5c6d894e 100644
>>> --- a/fs/nfsd/nfsctl.c
>>> +++ b/fs/nfsd/nfsctl.c
>>> @@ -47,6 +47,7 @@ enum {
>>> NFSD_MaxBlkSize,
>>> NFSD_MaxConnections,
>>> NFSD_Filecache,
>>> + NFSD_Rpc_Status,
>>> /*
>>> * The below MUST come last.  Otherwise we leave a hole in nfsd_files[]
>>> * with !CONFIG_NFSD_V4 and simple_fill_super() goes oops
>>> @@ -195,6 +196,13 @@ static inline struct net *netns(struct file *file)
>>> return file_inode(file)->i_sb->s_fs_info;
>>> }
>>>=20
>>> +static const struct file_operations nfsd_rpc_status_operations =3D {
>>> + .open =3D nfsd_rpc_status_open,
>>> + .read =3D seq_read,
>>> + .llseek =3D seq_lseek,
>>> + .release =3D nfsd_stats_release,
>>> +};
>>> +
>>> /*
>>>  * write_unlock_ip - Release all locks used by a client
>>>  *
>>> @@ -1394,6 +1402,7 @@ static int nfsd_fill_super(struct super_block *sb=
, struct fs_context *fc)
>>> [NFSD_MaxBlkSize] =3D {"max_block_size", &transaction_ops, S_IWUSR|S_IR=
UGO},
>>> [NFSD_MaxConnections] =3D {"max_connections", &transaction_ops, S_IWUSR=
|S_IRUGO},
>>> [NFSD_Filecache] =3D {"filecache", &nfsd_file_cache_stats_fops, S_IRUGO=
},
>>> + [NFSD_Rpc_Status] =3D {"rpc_status", &nfsd_rpc_status_operations, S_I=
RUGO},
>>> #ifdef CONFIG_NFSD_V4
>>> [NFSD_Leasetime] =3D {"nfsv4leasetime", &transaction_ops, S_IWUSR|S_IRU=
SR},
>>> [NFSD_Gracetime] =3D {"nfsv4gracetime", &transaction_ops, S_IWUSR|S_IRU=
SR},
>>> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
>>> index 55b9d85ed71b..3e8a47b93fd4 100644
>>> --- a/fs/nfsd/nfsd.h
>>> +++ b/fs/nfsd/nfsd.h
>>> @@ -94,6 +94,7 @@ int nfsd_get_nrthreads(int n, int *, struct net *);
>>> int nfsd_set_nrthreads(int n, int *, struct net *);
>>> int nfsd_pool_stats_open(struct inode *, struct file *);
>>> int nfsd_stats_release(struct inode *, struct file *);
>>> +int nfsd_rpc_status_open(struct inode *inode, struct file *file);
>>> void nfsd_shutdown_threads(struct net *net);
>>>=20
>>> static inline void nfsd_put(struct net *net)
>>> @@ -511,12 +512,18 @@ extern void nfsd4_ssc_init_umount_work(struct nfs=
d_net *nn);
>>>=20
>>> extern void nfsd4_init_leases_net(struct nfsd_net *nn);
>>>=20
>>> +const char *nfsd4_op_name(unsigned int opnum);
>>> #else /* CONFIG_NFSD_V4 */
>>> static inline int nfsd4_is_junction(struct dentry *dentry)
>>> {
>>> return 0;
>>> }
>>>=20
>>> +static inline const char *nfsd4_op_name(unsigned int opnum)
>>> +{
>>> + return "unknown_operation";
>>> +}
>>> +
>>> static inline void nfsd4_init_leases_net(struct nfsd_net *nn) { };
>>>=20
>>> #define register_cld_notifier() 0
>>> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
>>> index 460219030ce1..237be14d3a11 100644
>>> --- a/fs/nfsd/nfssvc.c
>>> +++ b/fs/nfsd/nfssvc.c
>>> @@ -998,6 +998,15 @@ int nfsd_dispatch(struct svc_rqst *rqstp)
>>> if (!proc->pc_decode(rqstp, &rqstp->rq_arg_stream))
>>> goto out_decode_err;
>>>=20
>>> + /*
>>> + * Release rq_status_counter setting it to an odd value after the rpc
>>> + * request has been properly parsed. rq_status_counter is used to
>>> + * notify the consumers if the rqstp fields are stable
>>> + * (rq_status_counter is odd) or not meaningful (rq_status_counter
>>> + * is even).
>>> + */
>>> + smp_store_release(&rqstp->rq_status_counter, rqstp->rq_status_counter=
 | 1);
>>> +
>>> rp =3D NULL;
>>> switch (nfsd_cache_lookup(rqstp, &rp)) {
>>> case RC_DOIT:
>>> @@ -1015,6 +1024,12 @@ int nfsd_dispatch(struct svc_rqst *rqstp)
>>> if (!proc->pc_encode(rqstp, &rqstp->rq_res_stream))
>>> goto out_encode_err;
>>>=20
>>> + /*
>>> + * Release rq_status_counter setting it to an even value after the rpc
>>> + * request has been properly processed.
>>> + */
>>> + smp_store_release(&rqstp->rq_status_counter, rqstp->rq_status_counter=
 + 1);
>>> +
>>> nfsd_cache_update(rqstp, rp, rqstp->rq_cachetype, statp + 1);
>>> out_cached_reply:
>>> return 1;
>>> @@ -1101,3 +1116,128 @@ int nfsd_stats_release(struct inode *inode, str=
uct file *file)
>>> mutex_unlock(&nfsd_mutex);
>>> return ret;
>>> }
>>> +
>>> +static int nfsd_rpc_status_show(struct seq_file *m, void *v)
>>> +{
>>> + struct inode *inode =3D file_inode(m->file);
>>> + struct nfsd_net *nn =3D net_generic(inode->i_sb->s_fs_info, nfsd_net_=
id);
>>> + int i;
>>> +
>>> + seq_puts(m, "# XID FLAGS VERS PROC TIMESTAMP SADDR SPORT DADDR DPORT =
COMPOUND_OPS\n");
>>> +
>>> + rcu_read_lock();
>>> +
>>> + for (i =3D 0; i < nn->nfsd_serv->sv_nrpools; i++) {
>>> + struct svc_rqst *rqstp;
>>> +
>>> + list_for_each_entry_rcu(rqstp,
>>> + &nn->nfsd_serv->sv_pools[i].sp_all_threads,
>>> + rq_all) {
>>> + struct {
>>> + struct sockaddr daddr;
>>> + struct sockaddr saddr;
>>> + unsigned long rq_flags;
>>> + const char *pc_name;
>>> + ktime_t rq_stime;
>>> + __be32 rq_xid;
>>> + u32 rq_vers;
>>> + /* NFSv4 compund */
>>> + u32 opnum[NFSD_MAX_OPS_PER_COMPOUND];
>>> + } rqstp_info;
>>> + unsigned int status_counter;
>>> + char buf[RPC_MAX_ADDRBUFLEN];
>>> + int opcnt =3D 0;
>>> +
>>> + /*
>>> + * Acquire rq_status_counter before parsing the rqst
>>> + * fields. rq_status_counter is set to an odd value in
>>> + * order to notify the consumers the rqstp fields are
>>> + * meaningful.
>>> + */
>>> + status_counter =3D smp_load_acquire(&rqstp->rq_status_counter);
>>> + if (!(status_counter & 1))
>>> + continue;
>>> +
>>> + rqstp_info.rq_xid =3D rqstp->rq_xid;
>>> + rqstp_info.rq_flags =3D rqstp->rq_flags;
>>> + rqstp_info.rq_vers =3D rqstp->rq_vers;
>>> + rqstp_info.pc_name =3D svc_proc_name(rqstp);
>>> + rqstp_info.rq_stime =3D rqstp->rq_stime;
>>> + memcpy(&rqstp_info.daddr, svc_daddr(rqstp),
>>> +       sizeof(struct sockaddr));
>>> + memcpy(&rqstp_info.saddr, svc_addr(rqstp),
>>> +       sizeof(struct sockaddr));
>>> +
>>> +#ifdef CONFIG_NFSD_V4
>>> + if (rqstp->rq_vers =3D=3D NFS4_VERSION &&
>>> +    rqstp->rq_proc =3D=3D NFSPROC4_COMPOUND) {
>>> + /* NFSv4 compund */
>>> + struct nfsd4_compoundargs *args =3D rqstp->rq_argp;
>>> + int j;
>>> +
>>> + opcnt =3D args->opcnt;
>>> + for (j =3D 0; j < opcnt; j++) {
>>> + struct nfsd4_op *op =3D &args->ops[j];
>>> +
>>> + rqstp_info.opnum[j] =3D op->opnum;
>>> + }
>>> + }
>>> +#endif /* CONFIG_NFSD_V4 */
>>> +
>>> + /*
>>> + * Acquire rq_status_counter before reporting the rqst
>>> + * fields to the user.
>>> + */
>>> + if (smp_load_acquire(&rqstp->rq_status_counter) !=3D status_counter)
>>> + continue;
>>> +
>>> + seq_printf(m,
>>> +   "%04u %04ld NFSv%d %s %016lld",
>>> +   be32_to_cpu(rqstp_info.rq_xid),
>>=20
>> It's proper to display XIDs as 8-hexit hexadecimal values, as you
>> did before. "0x%08x" is the correct format, as that matches the
>> XID display format used by Wireshark and our tracepoints.
>>=20
>>=20
>>> +   rqstp_info.rq_flags,
>>=20
>> I didn't mean for you to change the flags format to decimal. I was
>> trying to point out that the content of this field will need to be
>> displayed symbolically if we care about an easy user experience.
>>=20
>> Let's stick with hex here. A clever user can read the bits directly
>> from that. All others should have a tool that parses this field and
>> prints the list of bits in it symbolically.
>>=20
>>=20
>>> +   rqstp_info.rq_vers,
>>> +   rqstp_info.pc_name,
>>> +   ktime_to_us(rqstp_info.rq_stime));
>>> + seq_printf(m, " %s",
>>> +   __svc_print_addr(&rqstp_info.saddr, buf,
>>> +    sizeof(buf), false));
>>> + seq_printf(m, " %s",
>>> +   __svc_print_addr(&rqstp_info.daddr, buf,
>>> +    sizeof(buf), false));
>>> + if (opcnt) {
>>> + int j;
>>> +
>>> + seq_puts(m, " ");
>>> + for (j =3D 0; j < opcnt; j++)
>>> + seq_printf(m, "%s%s",
>>> +   nfsd4_op_name(rqstp_info.opnum[j]),
>>> +   j =3D=3D opcnt - 1 ? "" : ":");
>>> + } else {
>>> + seq_puts(m, " -");
>>> + }
>>=20
>> This looks correct to me.
>>=20
>> I'm leaning towards moving this to a netlink API that can be
>> extended over time to handle other stats and also act as an NFSD
>> control plane, similar to other network subsystems.
>>=20
>> Any comments, complaints or rotten fruit from anyone?
>=20
> I think netlink is the best way forward.  'cat' is nice, but not
> necessary.  We have an established path for distributing tools for
> working with nfsd so we get easily get a suitable tool into the hands of
> our users.
>=20
> The only fruit I have relates to the name "rpc_status", and it probably
> over-ripe rather than rotten :-)
> In the context of RPC, "status" means the success/failure result of a
> request.  That is not what this file provides.  It is a list of active
> requests.  So maybe "active_rpc".
> One advantage of netlink is that the API is based on numbers, not names!

There won't be a file name with netlink, so right, it won't be an
issue.

Lorenzo, can you proceed with netlink instead of /proc/fs/nfsd?=20
Maybe start with a yaml spec file?


> NeilBrown
>=20
>=20
>>=20
>>=20
>>> + seq_puts(m, "\n");
>>> + }
>>> + }
>>> +
>>> + rcu_read_unlock();
>>> +
>>> + return 0;
>>> +}
>>> +
>>> +/**
>>> + * nfsd_rpc_status_open - open routine for nfsd_rpc_status handler
>>> + * @inode: entry inode pointer.
>>> + * @file: entry file pointer.
>>> + *
>>> + * nfsd_rpc_status_open is the open routine for nfsd_rpc_status procfs=
 handler.
>>> + * nfsd_rpc_status dumps pending RPC requests info queued into nfs ser=
ver.
>>> + */
>>> +int nfsd_rpc_status_open(struct inode *inode, struct file *file)
>>> +{
>>> + int ret =3D nfsd_stats_open(inode);
>>> +
>>> + if (ret)
>>> + return ret;
>>> +
>>> + return single_open(file, nfsd_rpc_status_show, inode->i_private);
>>> +}
>>> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
>>> index 7838b37bcfa8..b49c0470b4fe 100644
>>> --- a/include/linux/sunrpc/svc.h
>>> +++ b/include/linux/sunrpc/svc.h
>>> @@ -251,6 +251,7 @@ struct svc_rqst {
>>> * net namespace
>>> */
>>> void ** rq_lease_breaker; /* The v4 client breaking a lease */
>>> + unsigned int rq_status_counter; /* RPC processing counter */
>>> };
>>>=20
>>> /* bits for rq_flags */
>>> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
>>> index af692bff44ab..83bee19df104 100644
>>> --- a/net/sunrpc/svc.c
>>> +++ b/net/sunrpc/svc.c
>>> @@ -1656,7 +1656,7 @@ const char *svc_proc_name(const struct svc_rqst *=
rqstp)
>>> return rqstp->rq_procinfo->pc_name;
>>> return "unknown";
>>> }
>>> -
>>> +EXPORT_SYMBOL_GPL(svc_proc_name);
>>>=20
>>> /**
>>>  * svc_encode_result_payload - mark a range of bytes as a result payloa=
d
>>> --=20
>>> 2.41.0
>>>=20
>>=20
>> --=20
>> Chuck Lever
>>=20
>=20

--
Chuck Lever


