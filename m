Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F647C8E5F
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Oct 2023 22:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbjJMUag (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Oct 2023 16:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbjJMUaf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Oct 2023 16:30:35 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12EA83
        for <linux-nfs@vger.kernel.org>; Fri, 13 Oct 2023 13:30:31 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39DIEbLZ003520;
        Fri, 13 Oct 2023 20:30:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 cc : to : from : subject : content-type : mime-version; s=corp-2023-03-30;
 bh=TvLetzwDCX2eFdKblWPH9ssFdnpPHENITA049361HMI=;
 b=sUTg1AEiWEr1mWANZsaYB0fpQKHhq56gRiEpeKYxIHDfWt5w5aS7ybFe13imYf6Cy44Y
 pgW+b0QmXrQRDNvZAy74HwkEhWn2YTa8OFyTAa8C0sID/v3AnUS+bc5TTCfmnqvyVGeM
 /0gC8GMWuZQzrCXzzs30Yp5IXquusLfpTinwagdjZtwJd9f22zMOC49YnWxWpjPpFGbU
 nZeCBTCjVnWC1lIn1rnmVUnIoW944KkPI0gqhrRXVXQ+gnPl+LyyqbJAHsICVzlzqJeq
 iTl3msmStxvFx7wp/QfIkHPycyhHuK6aaYJXPdDoDYNZlzqacrG4bYzVUxcEDT2OcBPS UA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjycdwxyt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Oct 2023 20:30:16 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39DIVfxc036851;
        Fri, 13 Oct 2023 20:30:16 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tpt0uw5uy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Oct 2023 20:30:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JZG/tbXEpCuwzx3j6udX5esSAm/+kqTZexg11vRgI8Y1hRoG9XePR70uNFiwdxtN4cPY/Sd9ckXwj+AJPeK4Q/ZxBGkZ5ffJTkM4QTL1W7Kze5ZkarLqhzG/v+vLeJzlLFAxZgPKuV6SVEtSNhb6zbNci2+8xnLUCyCYrFQzfcXJNVQyjUZMWe2FQxMUYEe4TO0XICwh9LfEUN8jQ6i5eli5rC1tNp3g53qRg5r22iTjIndtZcC3DQXD46mt0dxPyZgAGEoGuJOcf/AhQvXxp76j4rbRsvRmRXdlThMues6E3qwC0nTOwi0a+5qo3Yvw08RHCo/FIDjO81HDqFUs6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TvLetzwDCX2eFdKblWPH9ssFdnpPHENITA049361HMI=;
 b=SyXpHg+BBxDrX03gCuH4qNhuXEf2oKMKsJnXUMw0Mk16+Rc13TFTkkA64fBc+3PLBBARYdTy2fsTDkdjeXElItRnbJy4EgAEi+hDEt2KRkDZ/p5oQV8iDMorwQwVL9vVUhcVazcdxDp9u0YEogFtQrHRL0PidNN/TjEiuUQuI5c6U7kkOy7ZKfpEVXCj7npxjf9OCZjPRD8zChYOHNbHL/6gbh9X3E8QAL5Go4cHXV77JKd+wWV4A4FcxQfTYTH/w1o59XHqrPdjt1nmAMDPHOK/6KebBeYXlSnAjHmRM7Nw3S2JuWiHuLzkR+xiKJa87JgykPeT35/BHiRtV93o1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TvLetzwDCX2eFdKblWPH9ssFdnpPHENITA049361HMI=;
 b=VQoHLtv8t/l5d158EjBkgW9KzXfdLHxcNS9+Qm8OdXA1sWlAZ7vKFL6jQ4SiEaTpE7IqNdoPOdfY+ddTTmPxBrriu0a54eH8IPcSmrs2oDhgOeD06aaiOz+Z3zo7J7k30xeCgTaNa/JP69fDhpAZ5fWSFsIb6gu/JLSDcPFfSY4=
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by CH3PR10MB7629.namprd10.prod.outlook.com (2603:10b6:610:167::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.39; Fri, 13 Oct
 2023 20:30:14 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::834d:507e:a685:808d]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::834d:507e:a685:808d%7]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 20:30:14 +0000
Message-ID: <df6491a1-0e22-482e-9c99-a30a772cfe9d@oracle.com>
Date:   Fri, 13 Oct 2023 21:30:09 +0100
User-Agent: Thunderbird Daily
Cc:     Calum Mackay <calum.mackay@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, Dai Ngo <dai.ngo@oracle.com>,
        Frank Filz <ffilzlnx@mindspring.com>,
        Frank Filz <ffilz@redhat.com>
Content-Language: en-GB
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
From:   Calum Mackay <calum.mackay@oracle.com>
Subject: pynfs update
Autocrypt: addr=calum.mackay@oracle.com; keydata=
 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
 smRifw1wGg==
Organization: Oracle
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------pz5cFvRzgUxiy7PLCQmbqj3t"
X-ClientProxiedBy: LO2P265CA0091.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::31) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5143:EE_|CH3PR10MB7629:EE_
X-MS-Office365-Filtering-Correlation-Id: 68e47f11-ef63-46be-379f-08dbcc2b3485
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 80GvIwnnOX6Gu/jQP6raKApQzRr60g/6rk19M5C4w8el1WRw8KR3b4nEEFs+r6RGoMTdLfS+vOuW0C5U2a+U0SShtXA7KAwCVdePJ7aataFHY+fCCKzj3E4so22wPbPyx/kmfunHhMbr9IKD5osdYi1XpOR9OXYtvucYt2jzZ92EJcbqG0Lfu93VuEzlhyotbuvr9AWH+l6/c0W4njlbzIAeeqM2KVXuBI4yGxJiiHUy2wH7uU26dxlCmJz8kR3pFWg7LpNGlpX5nUw2N6eTOqCJoXJ56rGQ5ayw69VVOiEP8C8wcm9QZM1NZvFxEvx0f/Urs6mWaRBdUUFRQcIY+mZTGYKaZOBDsGrwfbhWjZX6ARDeN/8SBD5Jd8RMRGvNaYdw8NMx23sckfLw3AdSiOE6JjuEy2NebuVRQRHSVj/8CAYpy8uuWSyMbdJ6iexkeCg3Ns/EWMK9wZu9FjKckzID91xBlqcOGd7VulhU2xmI4qV0dUYE23zxpoJHCIazPNjcibO1JhPVCF7u+v46EO0NrzIA6OYSmMnXEZa02VgJnmu+i9y0k3UcTuCdTFbzN9SU/WVrhfeOXYJemU/S0VFslqhIqmJhIhi0XNVRRZHLG6ZiRcnztPzJyezMHppFaCbfhczxH1bTkBW7b/kWYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(136003)(376002)(396003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(36916002)(2616005)(6512007)(33964004)(6506007)(8676002)(66556008)(8936002)(7116003)(83380400001)(44832011)(2906002)(6916009)(478600001)(6666004)(6486002)(15650500001)(966005)(235185007)(316002)(66946007)(41300700001)(21480400003)(26005)(5660300002)(66476007)(54906003)(3480700007)(86362001)(4326008)(31696002)(36756003)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TldadGhWNDdyczZUQUU2c3RqRlVEajU5anViRzhDV1k2MnFyTzFZenNxck8w?=
 =?utf-8?B?eWtMd1JlcDkrTlJsOGJ1Vnh6SnZ6R2dnOTF4QUtUV1c4YWtIRTVNMy9FRjM2?=
 =?utf-8?B?T05iQyt1VkpIekZOSkZldDhwd0pKaU4vZXJNTDkxdVVIakREWFlwZlB0Sk8r?=
 =?utf-8?B?MlpHYVJqZ2tGeHBJcExoTmtXYk9LZFRtblV0SUVlVFZwc2UyQzA1bWR1M2U1?=
 =?utf-8?B?cGQ5NUxBSzc2YnZhUWpGM24yeU9ZclVsczNYMGVEQURiNHlvcCtib1RNRFdP?=
 =?utf-8?B?MHM4clNHM015c3BCaWxlekdwdnIvazlLMFFMOFZ1ZU9xWTFYWW5PTXpNc1Z1?=
 =?utf-8?B?U2FCMnZnYXNsTUFQMGp2U3ExMUM3VkVOY0dOeDBSV0JNQ1B6eUVoWTRBSURZ?=
 =?utf-8?B?dXlLOWJhQWMyb0dqT2lXTUk0d2Z1L2pKb0lpL0xycWZ3S0NTSFdHZG1TSUxR?=
 =?utf-8?B?ZWFKZnNCZCtibFh2RVJQTEQyTUQ0S0JwUStLejV5YXNLanVobjQ1MzJlZERJ?=
 =?utf-8?B?RGs1ZzNlTnJ1NTZHY3lKaG0wSEFjY2hna0c1dHdNUnNqcVBEMy8vbmFSMzJL?=
 =?utf-8?B?Q0ZrQVhSa3VNN2pubHNoNE1uTVBLanM5WnNzKy9vcHM3d1NlL01CUEIzOEZO?=
 =?utf-8?B?bmJVRWVRSzkwNVRFWFN6bXEzT25qL1dLR2pONG84aEZ2K3cvS0h5SVVkV3hP?=
 =?utf-8?B?QlFQWEJwazBRQ1hBR0FrWU9EbWZDUk5pM1RUbDY3dXB5NGRta2tTLzNkOXVT?=
 =?utf-8?B?Tk5iYnUxeGkxMjdGUGdRVkY2aEhiVG9IQWFZL3UwMCs5WjkzR21Ya2h0Mnp5?=
 =?utf-8?B?c3Y1ZjFoQjBYVmJERXdmY08wTDZaUDNwQ2Y2cURJUkUzSWNrQkZvVFp2bnJn?=
 =?utf-8?B?WEg4eXVRRThnbzJEa0sweGpvRTZLRXk2R2JubThkZzJEVTZoeE43cms3RUUr?=
 =?utf-8?B?SW9kajdlVGI3ckQyNSsyeTQ2WHhXYW14TFhjV0dtN0dGbkgxSllHTHpVdG05?=
 =?utf-8?B?TU1uT1NqSklxUDdMQlRXL2JsOUZKRE15RHNYTVVQUU1lMVZHaFViTUNBYi9s?=
 =?utf-8?B?QytWSWZHSlZyUlFlTzhNMEI1ekgzT3Zib2pmWFhJVXlZSS8yTDBLQ2w4d1pU?=
 =?utf-8?B?aCtFa2dOSDE1d1BhM2VGRGRkUE9GYUM3Mk0zQTBlTUd2cTFBYThDeDJyK0hu?=
 =?utf-8?B?QS9mTlJDYUhmaE1GY3B1c3JtMXEwZGgvd1RkdVp6WjFLSEFNV2hpRkxYZU52?=
 =?utf-8?B?QWtsSmJNbTZQaUZqb3RSQVVQU010amxvUS9VWDFycVZWWFNFM1p2bjN2WkUv?=
 =?utf-8?B?eUhaWlJIdmhkR0NGZlBGY1J0dVkvVUpXblFaWVpKeW5DcDhxazZrUXNmZms2?=
 =?utf-8?B?VGM1eklCdjJvMDNmSUJDUEpyOTM3OWNleHZTbkt3QUpOd2VHMFo2VXZKdWk2?=
 =?utf-8?B?bTZObXlRL2FhUzZTeXoxWnpPYjcvcjIwV2pTbjJReWdaSjVSSXNXM00yaWtI?=
 =?utf-8?B?V2VocXF3SVRyMW9DOTY1bm9SdXovYTdyaEswdnJsNE83LzFsWmh0dmU0eHd4?=
 =?utf-8?B?ZkpuRm9RNVlacC8zNjBIRlN6dktMb01aazVxTGZodjRDZ2oxemJCalphaFZD?=
 =?utf-8?B?V1Bqb3REaGZSY2NIMnFvdjV1TTBiVVplRThheHJvd1c5RU9UTHZQdFh5SzBF?=
 =?utf-8?B?VWhYcU54dUIvZ05uMTRFaWpTRlJ1TzRyUGhFdk9wRnhRaFB5VXVleUxqWHpC?=
 =?utf-8?B?NTNPbzNtSXZiNHlOdFJDWlNSK2tOTXpxczNDSlpOWVAvSENBblhMRE5kNi9k?=
 =?utf-8?B?ckRITkpxRVZKb1JWVFM1aG5OY0ZTdGNUanZFVkwrZXNYd1NjR1hSamVGdVVu?=
 =?utf-8?B?SEFHRVpCbnRUOEJBVndwRENIaG0xNWZNTTNBN2xNYXJEVkE0MEFMUWhNSjJ6?=
 =?utf-8?B?bDhPWkNkdkxrZC9tV2hrSVlsNHNmVTZOMGNjTUJ5VmZFZjBpUEpmc0xUc1ZG?=
 =?utf-8?B?T09VeDJGc2k5QVByaHRvd2R5QnhZTlhQSkVKMUJjaWxXNGtNNXFzSFcvVTgz?=
 =?utf-8?B?YUZjcFI3UEV0aGtEU2NTYTVMZFRUNWxFQ3krMjVsVFlzbVZKRlR4L2FqSUtG?=
 =?utf-8?B?T1NNOGJDbk15bXdOYTJsOEoxeFJDZ2kvNDZoQmFnUFpIeWwzUVdxMjNDalRN?=
 =?utf-8?B?L0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ke4bRECX+SpP1TJIN52UQA9/4L3YeOG7XpZ3B6/YfaB7i70WRYaM9LaCoQHK1UcZ/9+vZGR3W33vIhUNpWU6mpzJBAIw+Wv2Pkb4qNw50ftnjzKr7IPnsaOaX1rHKDZFqvbCZWqg8PCzbrgvd8rMTJNDeHHiaJYEXI1rUKxSVFUqzt8ewZ28A/XuOInt7xskywt//dOsSkcM8r+XpWSWUcNO8aQxCUiL0rEeN9HmeK9aFarSIE5qwJjXqHg9G8sM7OLGTpC7APHnaxhg9DeaqEX0K27DYKTwmE25eN8Ws2dvPcJPhvoaFQcpP90oIfI6skEDCntL3uJcRx8b00zqgE/5TjdvIK+m4D+NccvYzoP+pRRqBtaGzJWIxMqUzIDOFqIU/2EzpAOWPlEGk1d9zhAiaW1wpsC+LykhpqGWvt8Lx9ftdeOgztiJT1GKMPvc57SgjLKZ37DiugbR9bOw8/eNbIwfTOxDBGYugx4Un/ciu7wGvvl9AFdNm1UcgWbg7Fdjir1d/a1UDtt3/m8h7ZozS+qUkTsmsDRhCPWzi6KMifyhNqpz2b5u0pPKL1g8Pcg6+UGyFS6AA5xqKZUVS/0UPGmE0PHw7xIP082mMI8n3Ggw4KO50GJol/xZMCNk6b1Xyp54hPDkaWUYmcNpe9ow/L4/0B+04i1Bi9Sb8qAccZhHTIgxk+UJZGpx4Zsix1OZHGFXxYi3KOfd6WJEOiBrseBlSdq9Z/Xzu5b329kVFy04JGGcRAgqf6nfItqC29hPeVLEA+WyL/Jl5yZ5THAhkABXpTpzYZt+WqT9x5kkNCHD1UqVZeXniv7xWCcJZSo0zvRWmFETsA6lxhtCRkoGdAELYQ6f3ITiVMW8Ix0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68e47f11-ef63-46be-379f-08dbcc2b3485
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 20:30:14.1936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q24zyrDGhmr5b/UM3WwHb7HAzEjE/VyhDXQLUe+qwX1Nl2fv3C0ce08rJ2hd1u+Va5qbNA2pOxPIp3C/RdOu+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7629
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_12,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 malwarescore=0
 mlxlogscore=972 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310130177
X-Proofpoint-ORIG-GUID: -oQkopV0wPK-NQtMmaK6SBylueWzfzZu
X-Proofpoint-GUID: -oQkopV0wPK-NQtMmaK6SBylueWzfzZu
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--------------pz5cFvRzgUxiy7PLCQmbqj3t
Content-Type: multipart/mixed; boundary="------------iZ12OzmUhG8HK3fYTP3hmedH";
 protected-headers="v1"
From: Calum Mackay <calum.mackay@oracle.com>
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Cc: Calum Mackay <calum.mackay@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Dai Ngo <dai.ngo@oracle.com>, Frank Filz <ffilzlnx@mindspring.com>,
 Frank Filz <ffilz@redhat.com>
Message-ID: <df6491a1-0e22-482e-9c99-a30a772cfe9d@oracle.com>
Subject: pynfs update

--------------iZ12OzmUhG8HK3fYTP3hmedH
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SSd2ZSBiZWxhdGVkbHkgYXBwbGllZCBmaXZlIG9mIEplZmYncyBwYXRjaGVzIGZyb20gTWFy
Y2ggKHRoYW5rIHlvdSkgdG8gDQp0aGUgcHluZnMgdHJlZSwgYXQ6DQoNCglodHRwOi8vZ2l0
LmxpbnV4LW5mcy5vcmcvP3A9Y2RtYWNrYXkvcHluZnMuZ2l0O2E9c3VtbWFyeQ0KDQoNCkpl
ZmYgTGF5dG9uICg1KToNCiAgICAgICBuZnM0LjA6IGFkZCBhIHJldHJ5IGxvb3Agb24gTkZT
NEVSUl9ERUxBWSB0byBjb21wb3VuZCBmdW5jdGlvbg0KICAgICAgIGV4YW1wbGVzOiBhZGQg
YSBuZXcgZXhhbXBsZSBsb2NhbGhvc3RfaGVscGVyLnNoIHNjcmlwdA0KICAgICAgIG5mczQu
MC90ZXN0c2VydmVyLnB5OiBkb24ndCByZXR1cm4gYW4gZXJyb3Igd2hlbiB0ZXN0cyBmYWls
DQogICAgICAgdGVzdHNlcnZlci5weTogYWRkIGEgbmV3IChzcGVjaWFsKSAiZXZlcnl0aGlu
ZyIgZmxhZw0KICAgICAgIExPQ0syNDogZml4IHRoZSBsb2NrX3NlcWlkIGluIHNlY29uZCBs
b2NrIHJlcXVlc3QNCg0KDQpJJ3ZlIGdldCBvbiB3aXRoIHRoZSByZXN0IG9mIHRoZSBweW5m
cyBiYWNrbG9nIG5leHQgd2Vlay4NCg0KY2hlZXJzLA0KY2FsdW0uDQoNCg==

--------------iZ12OzmUhG8HK3fYTP3hmedH--

--------------pz5cFvRzgUxiy7PLCQmbqj3t
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE1GBbrQYgx8o9Vdw+hSPvAG3BU+IFAmUpqNEFAwAAAAAACgkQhSPvAG3BU+LI
0A/9ECs3EQRVJogztTq6dzLuvBXNxi6oR0NBJ8N+I7g4D1oVn+J6p9642Jyrl90fWgAa9qWKav93
LngIegOJV0rrDwzKEwGRT8Tz+53IyP8OluAWBgYlHNS489ngp5YrsshJCZBMJ2Zp6qSdVI8KSy67
8m3GwKFVfahaltuMcflV43RZxORUtQGxJM+BfeAk03eZ0niRC5aNbjLcCS8GLRdzyGJD1oaB5FWj
47MsY3ztali11u6NiZHQ+kbIxTK0aqmnOO0lAOWHMBhLs3dj9kv2uCkblX0VK2EEOHGm384Tqaym
WqCuURTfsmo2Wv3TW7+dBoit5PHHpfIq7SX+seRrdtahiHEqjqe05g5m3NRSO7wTxUKFewj3C+Kb
Hh7iuq8RXkWgcxsE8a2gcdaUVGTwwc1NE7R65Yq9WCAwSbA9GA5gU48EI9iqcX1zKrK9eGu7SWJB
D85xzg3KB0CTr+SLpbjPQJpFgIghXxG6l8QOFK055texhmSqBrWlri+K7X7zZASuUuqKDfXqLkGj
QrKL8pmk+UWn0aBFWvmYId3ENnPJSMP6CaNHqjBVUEPSelC/9mUMzGiyQvGl2TT9XBMd9GX/U170
O51ANNi6d5AObfZE8Sculg+P6sg8ZjVIefdGD0Rlvgc+pCXG1OjHcMD6aWI9NSpbxUJK3qMIQW5Y
BD0=
=VhI3
-----END PGP SIGNATURE-----

--------------pz5cFvRzgUxiy7PLCQmbqj3t--
