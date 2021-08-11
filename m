Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F079E3E9A4D
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Aug 2021 23:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbhHKVRW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Aug 2021 17:17:22 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:38488 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232073AbhHKVRV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Aug 2021 17:17:21 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17BLBs0V022919;
        Wed, 11 Aug 2021 21:16:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=zISoZ3kjeaX3SDct1Pyz3b/6lOCvZqTECiQlqrPQL1Q=;
 b=Ijv1ITyaaYoAr33nhwpO+b72UVQbydlNVri8Z4gF6wGme2+1WiIjwwXCPFqQ8tldzOy7
 rb7tcorLSJdZh6BWGe9kX8I9OIU2VGlsJxu/Rj+zryhHBCAMdr16I9Z1qVTJcgf6IGyH
 Copek3QXQWhCgoEPg+mfGbEblsU3yLr48EitLt0R6yDyEQ+YSjTmToNZYvU1HfXYTKbe
 YAWK8ZLdW9CitaPciCYuqFrgfLr+b9kS+OpySCW/xL9e45Wkumq5E1wAt+KFO+PqOvHp
 89Z0nLX3Yb5UsfIDBQUQZXAXTodagAlRERBjgtfTnjF1bOE9g3269i9YrC+GybxIr4nZ AA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=zISoZ3kjeaX3SDct1Pyz3b/6lOCvZqTECiQlqrPQL1Q=;
 b=L4QRURXJkomVgclO1xq5kpF81X4FNVK23v74GWsmsLjuqJUe0iDuzPgbVHP+18mcoG2R
 ozc/UOJhCfTE+Tt2Oqc9O24Tf6dIiJTRZ1GOD2+Kze/Vkqo9ZYD7VdaFX8lBG2lQ1Pro
 ZGv38q7+Va8hLPh+x9gKXQL/ja2eZIGIywbCZetbTC3y/I/hEXD9N5mkh3kcN09QTevw
 Lmq0Ekc6SHtLK64ffPr3pzjtlcWEdQnw2CpxM0ZaPcMi7mKOeQp1dJeTnjzTnMEwr/+X
 TJwXSPSpSKGeOCbsx5u61ctkXGDmK+FDevpL3IgXHdR/r8NagooihQ4aqOZTy8k8lx8A 3w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3abwqguavq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Aug 2021 21:16:40 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17BLGb4J128170;
        Wed, 11 Aug 2021 21:16:39 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by aserp3030.oracle.com with ESMTP id 3abx3we1cn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Aug 2021 21:16:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cbVlBGGwJSIWve20pI89IVcnFlvZqHwfG1FOVcUMX3GPMrdG7Vc3JRUwGDjVDgugMu/HCyP1JTfQinyNjHVkWOmng/YVAPGMbD5yAsG1N7zHkEddI6xODOpLZYuwSCvoQOWXYu4OBdkQ1etAbS0AacKEgbPUf0THvgwh5YTberYlyYUTWHb+v1MHY5a48s0lphZDmhVABlvGuEF68cJlNVx6KMgCjsZ5ojOrz/J5C45pyDf22FGh7l5bVB0/ZWkpNx5S0Qzd9D1oegulI1qDYrbsuIytjjakRIbVAEwZPH+OAKAA3689dJ4ZWIThBXK7yuZaiiy44SC9QC0C5eDC/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zISoZ3kjeaX3SDct1Pyz3b/6lOCvZqTECiQlqrPQL1Q=;
 b=S6+RnxXwjS3vT9YyicJFPs3hb7Af8iiFksBhO3G1l5CnTAYhL8H2M/49zTwfXWU7DJizF1an2s3YDmETXoBJm4GXKknJgS4WorxIgK0lcNL1xPJQdE/O0H/VqiqsHAWMGu7HHKktYmzo79bNVTs1gGKI5HjpxO+TVkJlip2ne75re+gPXeCXNAYU/tyMFSmp8gZTIZwg+V3YqDrLycNLv0o3W6+bS/E2OwtZq0uM6qHBnNvbP/+XQARLuamhamq9+jc58iVNyYKhEv/2p+ndkmwuyHKIk+Mh/a76DXX+hlh+Of+nlLz+zSgh0ss2j3xyaQu3XgUrrITvbkJqtbOHcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zISoZ3kjeaX3SDct1Pyz3b/6lOCvZqTECiQlqrPQL1Q=;
 b=A27Mzi+Dgj3w8vIgdM+/J3OspzoZvTEgMMmmV488t2BAkiqDq4NQ6P0mmNh5yiRGQHh+jc5cPRpFtHOPcQARdabnMKDTzBAjh3Aq56jszRUXspFDqnDZV4UzxitGZid30s+clN1n+d6vAfVqOQwa6bf1by0muO8vys44G0Eb04w=
Authentication-Results: thkukuk.de; dkim=none (message not signed)
 header.d=none;thkukuk.de; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4270.namprd10.prod.outlook.com (2603:10b6:208:1d6::21)
 by MN2PR10MB4269.namprd10.prod.outlook.com (2603:10b6:208:1d1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Wed, 11 Aug
 2021 21:16:26 +0000
Received: from MN2PR10MB4270.namprd10.prod.outlook.com
 ([fe80::d4ce:8d06:46e1:8639]) by MN2PR10MB4270.namprd10.prod.outlook.com
 ([fe80::d4ce:8d06:46e1:8639%4]) with mapi id 15.20.4415.016; Wed, 11 Aug 2021
 21:16:25 +0000
Subject: Re: [PATCH v2 1/1] Fix DoS vulnerability in libtirpc
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     libtirpc List <libtirpc-devel@lists.sourceforge.net>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Steve Dickson <steved@redhat.com>,
        "kukuk@thkukuk.de" <kukuk@thkukuk.de>
References: <20210811000818.95985-1-dai.ngo@oracle.com>
 <FB734534-39C5-4C07-9E06-65E052D04BB0@oracle.com>
From:   dai.ngo@oracle.com
Message-ID: <695d3e57-4227-04d6-4702-12ee381671df@oracle.com>
Date:   Wed, 11 Aug 2021 14:16:22 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
In-Reply-To: <FB734534-39C5-4C07-9E06-65E052D04BB0@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: SA9P221CA0016.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::21) To MN2PR10MB4270.namprd10.prod.outlook.com
 (2603:10b6:208:1d6::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-159-238-224.vpn.oracle.com (138.3.200.32) by SA9P221CA0016.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17 via Frontend Transport; Wed, 11 Aug 2021 21:16:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e88b0fb-947b-4059-91f0-08d95d0d4700
X-MS-TrafficTypeDiagnostic: MN2PR10MB4269:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR10MB426931D0E99BD2357F84B63987F89@MN2PR10MB4269.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oFDs3hPoRZPlrQ/cqU/iiXkOMupfKsUe3P6Qoa39H+zCrvoMwBI3vE6QBI3vurYIN7D5pXfLDX7hU/BOY3xM0JJBm9eHB2E7co/OomETu3/I0E2muWzs9tSZ7hI8bs3u0RlZTheGpv7w+vEGbbiKhuXrYTDlpE1Bn/8GT8J1BpTZDbt0WAxgvmwgILVOVZVQo3BwIjKPSZ9cEw7yylGUdYp2suStSdgW4pf4hnPMANsE263doEtrpUyY1qgOCCgrIKKuEYuuio8w0wojgW0DqP87yfqnz+wSlwvalBSZv7s39T/sQ9Q09sQImnu9eKV9vF5h9nveJBFw51LzNei/7ff7gUviLtXngaL0XtXIOkUOSEhXEV7aFJdDSMyeQ3yi1Wd5xGlklnIuvWH3yffuJ3DN3B65UEafma+Ue3W8iB0ESpyfefc5g1Dum3bpnkoxL2vg7tRfXZ2jNpGijtLFU8NTL6gZPFuDWallM8jLeNAbuF3ukXm4a5NJbylZnB9LxHM+TWKWSo0l24zeLcny5DwJtUvrwppqfmz6FFZI4/1ZtQtpxQIPrpkhTh9T/inZ6cuX5vGSq1oST7F9KiEJxdmB/Wuumcr+n1FiEh0sm4J/sGcjAuKBXash75a7LM8W1pZgMsAY9kY7rCzXnt385UrZjT8N+VuHwChxjE3/8r3dALu4ycXZlysMUsD0GjdA2tjmLv7VIBp3dOuge3d6Eg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4270.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(956004)(2616005)(53546011)(508600001)(8936002)(186003)(9686003)(54906003)(31696002)(8676002)(4326008)(83380400001)(7696005)(86362001)(38100700002)(66476007)(6862004)(316002)(66946007)(2906002)(36756003)(66556008)(5660300002)(37006003)(6486002)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkRseU1DR01WVm9KK2RGcWdQZ1ZjdFpsWWY0YjZKQjUrdkVtbGpkcHZoYk5M?=
 =?utf-8?B?aDFFTXcwdGJQYjRGNG5hcVVTNGExZHVtT0VQU2RJQWlBNUlwRXord01YWEJr?=
 =?utf-8?B?YmFtK0luUDEvZWo1bEhrZ3JGaGZ0MkcyOFJxbTVHOU5pd3lpVFN2NVVmYnlN?=
 =?utf-8?B?elBSNUFBdDg4L2c4QlNucHNmSXhBOFl3V2lTK1k1N3dTOUcwbkJJVDBMb0V4?=
 =?utf-8?B?MDZNZlVYMXFibVM3RUl4R2lzVk9mczdmL3B6RlpvMVpJbmoyUTc3ejFSck5S?=
 =?utf-8?B?V3J1TWJ5a1N0R3dBR29pRUovV3N1cU00aW5qTXBxY0h4UWNoUWV1bXRCTEZ1?=
 =?utf-8?B?YlZxaHIwKzAwTTNXc0xleUluQTNTd0kwaG9KVW90UGJHS2dWZVFuaU1EanlK?=
 =?utf-8?B?emViVWZ4aDZEV3dyYmZsTTJuYmxtYjZsbUJMYTdSVGN2WWgyS3I5MXhpODV4?=
 =?utf-8?B?RCtnQ1c5NWQwbHI0cE9FaUVKdldTOGZXM3gwRi9lbldvTDQ0NnM2K25ZU1Ri?=
 =?utf-8?B?dDFmTFBYRGI2S3NTTzc4NHIrMEdTWDM4U0NkTzRBODVnT0VLOXJhc2pCWEpN?=
 =?utf-8?B?OFQwRWIrOE1wVWxISEptSnlkNm1XT2ZvSHdZTGdrc3pWOEVPTzh1TFVYZks4?=
 =?utf-8?B?Z09pejU5ZHlQRjR2Rm5UK1EzcVVLVWhJU29UVnIxVGhUbmtMdkIzTWFJMndk?=
 =?utf-8?B?QTJYNEU1QUQ4bVNXVUdmeHZWUGZuY25lOVZBb3RNZWVOR3Zhdks2elBpYmRH?=
 =?utf-8?B?Sm8rY3FvUU1ucEpNQW1JWjdWSEttbldzc0c3N3hrYVA4QTdOS0psRjhNU1Nn?=
 =?utf-8?B?RHF5cmd4N0ZDcjhHaVpKTDIxVnVaRUpQdTc5dlRjUHgwV0ozZG5aaGFIWU9u?=
 =?utf-8?B?Y3JMcndGTWV0all1T2U1elQ1S2FmZWdWMndzMkROZnN1eEJMbTJtdndCMC9L?=
 =?utf-8?B?VVg0N3F2MTZKdGg4Wm56RlFORkd4VitKUVFhYTBtdTMySEozNENXY0tBd0di?=
 =?utf-8?B?NHpQeDROZzVtM0lvNDJGTTJCTElFVDJ4b1BSRkZwUlN1bytOQ3l0ZmZqOHRV?=
 =?utf-8?B?YUJsdHJ3aDE2VUkxVDRESFRwNWNneExFUXFaUUp4dWlCQ3JlQWZGdmNlNkVu?=
 =?utf-8?B?cEVpc04rOWw4bWdTZGVaV2YrTUN6UkhSU0picWVtaXNYZjlmVzJ2NThMR0dD?=
 =?utf-8?B?V2xkNE03NG84OFJTRWcrZVhteGkxSUpEMzNZN0lQdUQ4cE9YaG5IaVRXYjg3?=
 =?utf-8?B?RGUyZXZ2dFZTSXBrTDR3K0FyTkQ3SERPeENic1NKSlZDeFdrWmJiTDFGaFJr?=
 =?utf-8?B?OWc0NEk1RERDOER0cjdxejZwRXZQM0dGMVJFQUNzZ3RURkc0VVp5RkYrWSs0?=
 =?utf-8?B?R2Q3dlJCakVRN0hhMzllMHdFTDhWSmo5cDdpakY5RmhWREh5Ymo5N0dJbXBT?=
 =?utf-8?B?aW56MGhmVHR0VjZRNVVTekVSVHhZNWJPL2VnL0N1ZUFGNUNHRWo0QTEzRUZy?=
 =?utf-8?B?Z1gzQjdlRzYxYnRrbkFwQnJGOEtVcXFmTkRjUmxvd2FhOXduYjJvMjZianZ2?=
 =?utf-8?B?RWpRa1NVYU5zalhJblpQSlJ0NXNoNStBREg4OWRqTGVUa2VmSkdoOCtKaFdV?=
 =?utf-8?B?Qi9zS0grSWZkU2I3Qkx2RWZ3UCtuZlFyY2J5WVQ1YVpEMEVQN1RoU2hOUG16?=
 =?utf-8?B?Wk5SWFN6a3VlcW5hQnhXeTU3ckZWZ3oyYW9oQTN6WjQ5N0xBVEpSa2JFd0N0?=
 =?utf-8?Q?yYE8y5kQBACncdY5Fj2/gc+yboqtncaXQ3OJXTI?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e88b0fb-947b-4059-91f0-08d95d0d4700
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4270.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2021 21:16:25.8675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gFICjmDYd9e1TyEXJl+rD7Pg4xAxvspnVZVbG0vgDA20PSfyPSHALRwwd8XTg3kTXEnPKmheGW5Sj407mM0DjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4269
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10073 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 spamscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108110145
X-Proofpoint-ORIG-GUID: L_9F1mAKPanquDN4UjS94lJ6Ql_dPo0o
X-Proofpoint-GUID: L_9F1mAKPanquDN4UjS94lJ6Ql_dPo0o
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 8/11/21 12:43 PM, Chuck Lever III wrote:
>
>> On Aug 10, 2021, at 8:08 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>
>> Currently svc_run does not handle poll timeout and rendezvous_request
>> does not handle EMFILE error returned from accept(2 as it used to.
>> These two missing functionality were removed by commit b2c9430f46c4.
>>
>> The effect of not handling poll timeout allows idle TCP conections
>> to remain ESTABLISHED indefinitely. When the number of connections
>> reaches the limit of the open file descriptors (ulimit -n) then
>> accept(2) fails with EMFILE. Since there is no handling of EMFILE
>> error this causes svc_run() to get in a tight loop calling accept(2).
>> This resulting in the RPC service of svc_run is being down, it's
>> no longer able to service any requests.
>>
>> if [ $# -ne 3 ]; then
>>         echo "$0: server dst_port conn_cnt"
>>         exit
>> fi
>> server=$1
>> dport=$2
>> conn_cnt=$3
>> echo "dport[$dport] server[$server] conn_cnt[$conn_cnt]"
>>
>> pcnt=0
>> while [ $pcnt -lt $conn_cnt ]
>> do
>>         nc -v --recv-only $server $dport &
>>         pcnt=`expr $pcnt + 1`
>> done
>>
>> RPC service rpcbind, statd and mountd are effected by this
>> problem.
>>
>> Fix by enhancing rendezvous_request to keep the number of
>> SVCXPRT conections to 4/5 of the size of the file descriptor
>> table. When this thresold is reached, it destroys the idle
>> TCP connections or destroys the least active connection if
>> no idle connnction was found.
>>
>> Fixes: 44bf15b8 rpcbind: don't use obsolete svc_fdset interface of libtirpc
>> Signed-off-by: dai.ngo@oracle.com
> Thanks, Dai, this version makes me feel a lot better.
>
> I didn't look too closely at the new __svc_destroy_idle()
> function. I know you based it on __svc_clean_idle(), but
> I wonder if we have any regression tests in this area.

Thank you Chuck for your review.

So far I used the 'nc' tool to verify rpcbind, statd and mountd
no longer have this problem. I also verified that NFSv3 and NFSv4.x
mount also work while the tests were running. I don't know of any
tests specifically designed for this but I will look around to see
if we can use some NFS tests that would exercise these services.

-Dai
  

>
>
>> ---
>> src/svc.c    | 17 +++++++++++++-
>> src/svc_vc.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>> 2 files changed, 77 insertions(+), 2 deletions(-)
>>
>> diff --git a/src/svc.c b/src/svc.c
>> index 6db164bbd76b..3a8709fe375c 100644
>> --- a/src/svc.c
>> +++ b/src/svc.c
>> @@ -57,7 +57,7 @@
>>
>> #define max(a, b) (a > b ? a : b)
>>
>> -static SVCXPRT **__svc_xports;
>> +SVCXPRT **__svc_xports;
>> int __svc_maxrec;
>>
>> /*
>> @@ -194,6 +194,21 @@ __xprt_do_unregister (xprt, dolock)
>>      rwlock_unlock (&svc_fd_lock);
>> }
>>
>> +int
>> +svc_open_fds()
>> +{
>> +	int ix;
>> +	int nfds = 0;
>> +
>> +	rwlock_rdlock (&svc_fd_lock);
>> +	for (ix = 0; ix < svc_max_pollfd; ++ix) {
>> +		if (svc_pollfd[ix].fd != -1)
>> +			nfds++;
>> +	}
>> +	rwlock_unlock (&svc_fd_lock);
>> +	return (nfds);
>> +}
>> +
>> /*
>>   * Add a service program to the callout list.
>>   * The dispatch routine will be called when a rpc request for this
>> diff --git a/src/svc_vc.c b/src/svc_vc.c
>> index f1d9f001fcdc..3dc8a75787e1 100644
>> --- a/src/svc_vc.c
>> +++ b/src/svc_vc.c
>> @@ -64,6 +64,8 @@
>>
>>
>> extern rwlock_t svc_fd_lock;
>> +extern SVCXPRT **__svc_xports;
>> +extern int svc_open_fds();
>>
>> static SVCXPRT *makefd_xprt(int, u_int, u_int);
>> static bool_t rendezvous_request(SVCXPRT *, struct rpc_msg *);
>> @@ -82,6 +84,7 @@ static void svc_vc_ops(SVCXPRT *);
>> static bool_t svc_vc_control(SVCXPRT *xprt, const u_int rq, void *in);
>> static bool_t svc_vc_rendezvous_control (SVCXPRT *xprt, const u_int rq,
>> 				   	     void *in);
>> +static int __svc_destroy_idle(int timeout);
>>
>> struct cf_rendezvous { /* kept in xprt->xp_p1 for rendezvouser */
>> 	u_int sendsize;
>> @@ -313,13 +316,14 @@ done:
>> 	return (xprt);
>> }
>>
>> +
>> /*ARGSUSED*/
>> static bool_t
>> rendezvous_request(xprt, msg)
>> 	SVCXPRT *xprt;
>> 	struct rpc_msg *msg;
>> {
>> -	int sock, flags;
>> +	int sock, flags, nfds, cnt;
>> 	struct cf_rendezvous *r;
>> 	struct cf_conn *cd;
>> 	struct sockaddr_storage addr;
>> @@ -379,6 +383,16 @@ again:
>>
>> 	gettimeofday(&cd->last_recv_time, NULL);
>>
>> +	nfds = svc_open_fds();
>> +	if (nfds >= (_rpc_dtablesize() / 5) * 4) {
>> +		/* destroy idle connections */
>> +		cnt = __svc_destroy_idle(15);
>> +		if (cnt == 0) {
>> +			/* destroy least active */
>> +			__svc_destroy_idle(0);
>> +		}
>> +	}
>> +
>> 	return (FALSE); /* there is never an rpc msg to be processed */
>> }
>>
>> @@ -820,3 +834,49 @@ __svc_clean_idle(fd_set *fds, int timeout, bool_t cleanblock)
>> {
>> 	return FALSE;
>> }
>> +
>> +static int
>> +__svc_destroy_idle(int timeout)
>> +{
>> +	int i, ncleaned = 0;
>> +	SVCXPRT *xprt, *least_active;
>> +	struct timeval tv, tdiff, tmax;
>> +	struct cf_conn *cd;
>> +
>> +	gettimeofday(&tv, NULL);
>> +	tmax.tv_sec = tmax.tv_usec = 0;
>> +	least_active = NULL;
>> +	rwlock_wrlock(&svc_fd_lock);
>> +
>> +	for (i = 0; i <= svc_max_pollfd; i++) {
>> +		if (svc_pollfd[i].fd == -1)
>> +			continue;
>> +		xprt = __svc_xports[i];
>> +		if (xprt == NULL || xprt->xp_ops == NULL ||
>> +			xprt->xp_ops->xp_recv != svc_vc_recv)
>> +			continue;
>> +		cd = (struct cf_conn *)xprt->xp_p1;
>> +		if (!cd->nonblock)
>> +			continue;
>> +		if (timeout == 0) {
>> +			timersub(&tv, &cd->last_recv_time, &tdiff);
>> +			if (timercmp(&tdiff, &tmax, >)) {
>> +				tmax = tdiff;
>> +				least_active = xprt;
>> +			}
>> +			continue;
>> +		}
>> +		if (tv.tv_sec - cd->last_recv_time.tv_sec > timeout) {
>> +			__xprt_unregister_unlocked(xprt);
>> +			__svc_vc_dodestroy(xprt);
>> +			ncleaned++;
>> +		}
>> +	}
>> +	if (timeout == 0 && least_active != NULL) {
>> +		__xprt_unregister_unlocked(least_active);
>> +		__svc_vc_dodestroy(least_active);
>> +		ncleaned++;
>> +	}
>> +	rwlock_unlock(&svc_fd_lock);
>> +	return (ncleaned);
>> +}
>> -- 
>> 2.26.2
>>
> --
> Chuck Lever
>
>
>
