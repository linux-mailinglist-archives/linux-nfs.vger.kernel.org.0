Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEB1D3DF0CF
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Aug 2021 16:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235527AbhHCOyu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 3 Aug 2021 10:54:50 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:50738 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234206AbhHCOyu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 3 Aug 2021 10:54:50 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 173EoiOx015985;
        Tue, 3 Aug 2021 14:54:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : subject : to :
 message-id : date : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=0ec+YpPQY5bY0FBKveQLo3nPbjc7D2XnijRrVQqFgJs=;
 b=YLAyDdE6xqj+Ee1aG3pdY18YSwoipsuKpEt/oU1plXK3sR3crx5epImGdfgVRJWc/9Da
 veoZWqyW9FFLR9i64r9/ZsNQU72/Nty9F7e+YmKysSCYwIxITJzIQuwZn6By4wzvS7c1
 A2InIbdMkCmEPc12GUX2SGTuJkXKtpa4kd6ryJInCHQwJAsmg5mcsvIDahtrIdxX4L2f
 wPbneSv34Jlo/YbpnpvS9giaJKM9WvTMU61tef186Goe1nig2QgLSPLgZKlkHeiR4AU2
 TxXinIfvG/3mosa/Z6FISvLYPQAB9dv1afIexHxL54vtSqAVsLC2RplbOt3p7s7Z9Ddu Ug== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : subject : to :
 message-id : date : content-type : content-transfer-encoding :
 mime-version; s=corp-2020-01-29;
 bh=0ec+YpPQY5bY0FBKveQLo3nPbjc7D2XnijRrVQqFgJs=;
 b=yLsJij1yU7u2le0PXpDuvhgN7QEBshRFZJD/eqkpL1AGOM1OCK24NwgdSL+QDUzagMN+
 +DKPG/sT+vBv0TkwOthqtG/0v93QDdedd/YZAHw77f9UnlxXPF6BWfwYRH+qeOSi4yBU
 jZHtob8lziiBH9uxykUckGGiEfrIzsrJNA6GOa9dBrl7+xeTpcMxKc8H+6jeR0Gs6R4g
 10rP84mvMSiNWajG5oJkwObj/p48pIDVRhFnNULxwAZtQerOzcre9oK0ea6dDCA392sa
 OquNzT04hUteFVJ5txQ/47YOz37b3cYWC5zHNJ95DGkuAIVZgE4OIWTP7xGvBB2WFz8c 3A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a6fxhbc4j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Aug 2021 14:54:37 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 173EpKsr134140;
        Tue, 3 Aug 2021 14:54:36 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by userp3020.oracle.com with ESMTP id 3a5g9v7h0h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Aug 2021 14:54:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WpVfSyVlhMYPN9Qd1Ix3c7n9X2kb1sjUemkc7CkuetrEj8x5MPLs8mtNmUMF5hZz/yU9aw/Qwn4t7TK9neqcRFUgg1v1SMq6rmhhvgeYCZhDmiKQWr4gycyH5D9W27j0wzPqJcse79su0Ic4vpGbTC7w2dUWqHPktM67mkMHxAFsO+OcQ1toBgqvkIS/kaPM0tjSePMH6dVUG9vz527AQJY/bEZEVzperTuC21tzJopzo1CLp7I46i99ckniGoAeGCkRMT1Msu9ixa04h+YPFeUUkPVnRH2llvHUncC+xaExqcVa1MecCa6whG8AnmN2k0DOCG1cFDw4DAAZdAFNcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ec+YpPQY5bY0FBKveQLo3nPbjc7D2XnijRrVQqFgJs=;
 b=fZ37kr7QGkKOY62ko6Og90JqE3pkYXBGBMLTK7VzNh55h8cGsf5muhz32pyfiCFmtFlF41zPBkDNuq+nYC/Tz6F9hxFJd5JaTY4pDzd2EpK6KxkJH8k/Y29W4i9j4jRNa2D7gWl8CJJpgV8Y9l12T7DR4PWZY5qY27BdyUkg/5IUBFstYdgLa1lfd9kx80qOshyEcasMC4gfvbZEBR0QJ1QWzmymKK+1rCOfMihKi4z6qrzx+Uw0fAdHJrzfaJDiTUWmEiyqTlOzC6+ft2mfIiLl7STe1eh9q4xO/hE8oAWSXnvjR1i9/aDAvmq10ioZ1a+GkB2NgurKDi4m5sFhYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ec+YpPQY5bY0FBKveQLo3nPbjc7D2XnijRrVQqFgJs=;
 b=uYcQQUd/m1UZ+wjI67fFGZMaYfuG7zSaDFT5nJ6KqbsstgVOsYE5b+fGS4aeb2QmtHHHKaaFY3YWyJ3eotSLr1EJ2ejzoQj+JMhZZEiobBnHQD4MiXoeAVROd+Dqp7BH1aqMaHKF5AT5JID6pCnHKhXunJDleNSW+Qfynmh+JHM=
Authentication-Results: googlegroups.com; dkim=none (message not signed)
 header.d=none;googlegroups.com; dmarc=none action=none
 header.from=Oracle.com;
Received: from SA2PR10MB4668.namprd10.prod.outlook.com (2603:10b6:806:117::12)
 by SN6PR10MB2703.namprd10.prod.outlook.com (2603:10b6:805:4f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15; Tue, 3 Aug
 2021 14:54:34 +0000
Received: from SA2PR10MB4668.namprd10.prod.outlook.com
 ([fe80::502a:129b:1ce5:64eb]) by SA2PR10MB4668.namprd10.prod.outlook.com
 ([fe80::502a:129b:1ce5:64eb%7]) with mapi id 15.20.4373.026; Tue, 3 Aug 2021
 14:54:34 +0000
From:   Bill Baker <Bill.Baker@Oracle.com>
Subject: Announcing Fall 2021 NFS Bake-a-thon
To:     nfsv4@ietf.org, linux-nfs <linux-nfs@vger.kernel.org>,
        winter-2021-bakeathon@googlegroups.com
Message-ID: <7fa9bd9e-61e3-d9ad-413a-65f326048fbb@Oracle.com>
Date:   Tue, 3 Aug 2021 09:54:32 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR08CA0027.namprd08.prod.outlook.com
 (2603:10b6:805:66::40) To SA2PR10MB4668.namprd10.prod.outlook.com
 (2603:10b6:806:117::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from bills-mac-pro.lan (68.203.6.244) by SN6PR08CA0027.namprd08.prod.outlook.com (2603:10b6:805:66::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Tue, 3 Aug 2021 14:54:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c662fe4-6a56-4bd8-3a97-08d9568e9b3e
X-MS-TrafficTypeDiagnostic: SN6PR10MB2703:
X-Microsoft-Antispam-PRVS: <SN6PR10MB27037A5914DECA4C9BD5F32DF9F09@SN6PR10MB2703.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xh2BNGxTp1O+VN5wtkevZqaP0G14jiU7d+J81lNDsze5e0gGj4IVjcZBo//szbg7voBItYfwBtuXJ0MInhifzm+/Szz9tcvePdD5IskXxMUmeS6ODXliAFCyEiq89sutGUq2GIXkNp/Yb2G2x1TzsaJX9OJefcdEWmLPvNF8L6wX5xJkuDXH0tKkVuXozsOaKTzoRfMb2uln2iy+BdrByz8rZzIG+4t8SyhsofeHWq8lRnhv6ANewFJXhIHERlEqB1b7K+/VKpYAtdoMyW5r7k8UXsKjVu+JelMGlxxX42rSucyoRrgZ6r7QnyYVVQa7SD1jhgr26V8bT4JOKW6h7L5AIdEQOsuMtrq/0jHdCMmLheqdy+dboDzbTNfWh7eIDEUhljHuo86fB6svFeLiGNiwtMXfB6L/ZrsXaQoD37xRLw/+o79pvlsjzXD++SlmZ6jPlxfJJhb6QTnTjGDTu/Ou4X8Ty4FYYUa95gqW/Z79xw69e6TJHzMPrpEIhKZNcz9U35lA/xHetqhdATA5ESPE94FdYtLb/0krUh9FvZ+MeYXDfQ3cBKeahsjW1bSoIPT1KrYm/sHYteXQqiE+g+BfMD5gev2pLUyg6b+GJAwuHkWRPTfo/HYrFNkOrK1K6XJQK8ue80blqzAsOLhYSM7xQX00R85F6RziMmL9HsskvrAQunPR51hHpsl905of76/UIUoSJ9wKkK14sVSvxnBb40SaAuR8jzZ/KlQyW1RAlHjD3c09vBg8F2c0JMH2WmFnrHJ/QptwRWXV0CJPLPaXR/03DTnLbMZIUF/H2kOsqh/aCbEgBm7ZmNXUXUwC/8qyEF1e/2L/Y6vd6epHTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4668.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(376002)(396003)(136003)(39860400002)(186003)(2616005)(956004)(316002)(31686004)(66946007)(66556008)(66476007)(2906002)(6486002)(6506007)(6512007)(86362001)(31696002)(4744005)(8886007)(38100700002)(966005)(26005)(36756003)(5660300002)(8936002)(478600001)(8676002)(117716001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?Windows-1252?Q?ppFrYASaAa3Sguli1yoiWva57TsNhl6QdQ585j92sCyYDF1VnSOVG0BF?=
 =?Windows-1252?Q?uO1s9u6h9Jv/l9X2tZUCg98FkeYbeeBz0L/oyf+7Cmvs8yyip17yUr5m?=
 =?Windows-1252?Q?GTGirqTOe0oIUZIcXfW5xxwzdGyFqHEu7Vkb62uq1fdQEwgOgJHeehg6?=
 =?Windows-1252?Q?Jq+DvbUexiQuLeTWngv2OsLzH5OL5MYO+4H2BAaCpLHu+bisQM83fkso?=
 =?Windows-1252?Q?i9cfKuJlpHqKb4+S8IQdwJCgo4LDgcJJGTodZU8jkLL04uCQmWs45Dqp?=
 =?Windows-1252?Q?7k/cF/attkxyXXu1PN+USn3Eng1OjTWL8bmTe+Fv6HQh82J5B/xgs/yN?=
 =?Windows-1252?Q?FbbHasDP45IFUF3ngrd+x6TejXZYmcRDW2c5YkXcHuRlbTXPvd65fazg?=
 =?Windows-1252?Q?nnHyoVuhQ+MRN6dYrX3oPvoZFI61CdMhHZmQgoLNpPUCUeAPVycNtajJ?=
 =?Windows-1252?Q?Mr5fVAGD07K8jwHd4GVK0iFGVTF7yTa1uAVDM8LzpuASx/gJNyOO/FKh?=
 =?Windows-1252?Q?yM2XC5klXzxvNgn/ku7TfH3wuwD2oZGyUoCH8G9MDywOeTX7+rvdxZRa?=
 =?Windows-1252?Q?hAPdDJry22ZNxoEMZss8aGM0uEUkXEQ2xlTC4mDKM4jFOF3n60gKm+LX?=
 =?Windows-1252?Q?6DyPPdDPycR7xTykbASOzpMqHrmo5Pp/Xf91FoCRq0qjQqLQs6Dc7Bai?=
 =?Windows-1252?Q?GuW9USm/6Mj455P9WM9lC8/qymZvRGeAtX+TWHtC2APkK9C80JXQ+Lr6?=
 =?Windows-1252?Q?hDttExiikyE2WJNSziK9v2KcTRC/3FF1WlMVsRl2ED4rBGRTowuRG0WK?=
 =?Windows-1252?Q?mlTJkmWEyFPjTPX67a9i4XTW46vId4fc+AJFVG3a1RZFeiLpeVbNZvz2?=
 =?Windows-1252?Q?rELMF4DUZRSG27gbz4H4uER9Y1fCm/gq44VwkESux+7xQEdj24sf5WcD?=
 =?Windows-1252?Q?p/vGdxCoxOn6cq3n/0XindNALR3lWWBgcGdFtGutLZffVKvL6RLIN3/W?=
 =?Windows-1252?Q?iwjvqAYSWClThOtmycywAsuRvN5tIO4CKUIfc7QEXLZfiAsl211FE8Px?=
 =?Windows-1252?Q?7nLQWIq8cG5dUn94ONK9FNAJncTZB1d76W90H6wI2nUbnTS/2UfcMWsI?=
 =?Windows-1252?Q?HPMgUVb+MRQAlUN/BoQHZPNrPoKYyPSpEOQsiSdkW8dcWceDK6s0zb1E?=
 =?Windows-1252?Q?hEIQ5jL7wW7Sq/SQfWXYw7JaqwrYkXKmNmEDAU7LhZvgdbAWBvOERwIx?=
 =?Windows-1252?Q?UWkbTuu1N6+AkO6ITWrqBqTg61R9R4J31yhtdJXuC/6xdVbrUqmPQUCJ?=
 =?Windows-1252?Q?cdwui66/0JMsxnJRZ4EmVfaAi/9vTAMM+OA5hkfzf+yCWK9MCUt9HXaR?=
 =?Windows-1252?Q?gQoIvDkowKwt0DyorMSEsFqHlV0hMjzXGz0fYlbQtba+0FQc4BH2TzHt?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c662fe4-6a56-4bd8-3a97-08d9568e9b3e
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4668.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2021 14:54:34.0741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lVotcfLVhHKIpmCt+amN/AiU/Bz516eHjx8MY8eqbmzH0C41pM1O5mPOAipXaIm/4S2wd0DXrzn/zjDiU+sufA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2703
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10065 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=942 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108030098
X-Proofpoint-GUID: f8P5OFydCnnwRXmqTCujiAhyhIahxR1X
X-Proofpoint-ORIG-GUID: f8P5OFydCnnwRXmqTCujiAhyhIahxR1X
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


Greetings,

I am pleased to announce the Fall 2021 NFS bake-a-thon, October
4th-8th.  As before, we will be running this event in virtual
space.  There is no formal registration process, but please let
me know if you plan to attend.

For first time attendees, please note the VPN setup instructions
so that you can punch into the BAT network.  You can find information
on the website: http://nfsv4bat.org/Events/2021/Oct/BAT/index.html

If you are interested in giving a presentation (via discord), please
let me know.

Look forward to seeing you (virtually) at the next BAT.

-- 
Bill Baker - Oracle NFS development
