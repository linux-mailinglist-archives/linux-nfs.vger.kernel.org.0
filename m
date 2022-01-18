Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40D8C4929E0
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jan 2022 16:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345901AbiARPvf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Jan 2022 10:51:35 -0500
Received: from mail-eopbgr80125.outbound.protection.outlook.com ([40.107.8.125]:9348
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233324AbiARPve (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 18 Jan 2022 10:51:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDzpTCYsL+vyIOV7BtNO0ow59v3xOhdZrhhTrLid0OX5QM8lM6AqzoNn4SuE8nt97hCFu0bSBy0gBLXb51zigBOcHZTnDlsfAbvynJgbMBb09d8UOFq2xGEG3t/Sl/htxltnanLW8+xwX6HTXFUOJG7IFBF92hNTchASM7LRhR9lisOf9gQJ+Om+YHWlb/fQBxnk+np+pfLkEcqcnNJ9axMtdZPTmwCp5FP5hAyQakp5qbz93PcbV2liUJzMjDSWdt5ST+II+4qWMhDhNjYmr7sabbVq/cb33WuSU6TMMyQXUKsZa+L6HooJ4u2FLYTJHsa6OLRLpKMc08MmL0C0Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DYVp0ADBjazBzmquWiJmS4bhV8Q+3PZzEkpbmfwsYRs=;
 b=TFaLishRdvxga9FByXMT2ix9NlAf0tMDEddjmQHwcCxC4HVMJYXK+WwFspXb3R2hirpwr55+geFVvq6a85QpC2GVkneVJ7gwhIwtEXlsS6GbsMHeg/tX4M6K9sSpJyGMhpjrC6b3jjZHrROTGe7+RJUUKGodHKy+pDfzLjzTumgzRjZhiHJM1YAtTld9PU+VmOYEF6BLDHKFcXZvJrb0lRclz0soNd1sn6kcLivMDEvWeH4ElZPm7IHMOwvbKvsf1zQz3DfK6pyNS2DF1P1wOGIEM827y4UnqWvbw+N82U0w+TDI9OH7SCrg9UsQ52gUZN50pVzwDs/xsaCTJbGvqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DYVp0ADBjazBzmquWiJmS4bhV8Q+3PZzEkpbmfwsYRs=;
 b=DBlCUn6ThYPjF7fEv0nRQt06N91GMogmnhbJ/zBhhsxBhCZqaP9KTp33XXXVp8nQx2RYT8tGYWFRekplvF1bALITP8xA8sVPRPDH7EI27mNhCpuHOZc0E83dqBxYrMhOZDA+jRAzK9G7f1+YlNA6AlD+rSa/fSW1btPJACg9izo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB5630.eurprd08.prod.outlook.com (2603:10a6:800:1ae::7)
 by VI1PR08MB3488.eurprd08.prod.outlook.com (2603:10a6:803:7d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Tue, 18 Jan
 2022 15:51:30 +0000
Received: from VE1PR08MB5630.eurprd08.prod.outlook.com
 ([fe80::3c60:bb4b:b0eb:669d]) by VE1PR08MB5630.eurprd08.prod.outlook.com
 ([fe80::3c60:bb4b:b0eb:669d%3]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 15:51:30 +0000
Message-ID: <a35ebb8b-6e61-8445-cf19-285bf2f875ad@virtuozzo.com>
Date:   Tue, 18 Jan 2022 18:51:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: LTP nfslock01 test failing on NFS v3 (lockd: cannot monitor
 10.0.0.2)
Content-Language: en-US
To:     Petr Vorel <pvorel@suse.cz>, linux-nfs@vger.kernel.org
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Neil Brown <neilb@suse.de>, Steve Dickson <SteveD@redhat.com>,
        ltp@lists.linux.it, kernel@openvz.org
References: <YebcNQg0u5cU1QyQ@pevik>
From:   Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
In-Reply-To: <YebcNQg0u5cU1QyQ@pevik>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6PR08CA0044.eurprd08.prod.outlook.com
 (2603:10a6:20b:c0::32) To VE1PR08MB5630.eurprd08.prod.outlook.com
 (2603:10a6:800:1ae::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e15b8935-786f-4237-b3fa-08d9da9a64f2
X-MS-TrafficTypeDiagnostic: VI1PR08MB3488:EE_
X-Microsoft-Antispam-PRVS: <VI1PR08MB34883751577A6747EA04DD6BF4589@VI1PR08MB3488.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FDaePYP+d83rnYlLK16HCBFfUjvjubohXoJctf2AfL2B3YcAf4NbUzQasPdLCCS+kXwjB2MZ12F7IeJfzqMgj2MZAte1hseVlWDrLAfNwKCaaXmQW6oJekHbbb5jfMz8pNGrHj+AaCsTRjtTFaa9d3iYogSCuFvjbIjuPQgEcyaqCkVKiQBfB63ZGjCmGNMeST3YMjaUPDnMoi7ZGEUt9HhKV0zNyg94041GRS8yIuXrKPF0zXwZFlNKE70WhyM2mYZAsQvunHNJjy9fZF5CqTKx8XcaA8wwC+qakOzG5rMKJGS4SglErl7hC5erbu76ZdnAmoSYHg+qvSXDe7jRps4NheDKs/vyGWlgkjjG7ceYnD02azv86dws8pd1oAXDJ0sHCHYc4r9e34Fa7NvxIdKuF0ff8QaXKIUxxE5S+4VvCisV04dfqzleW6w896PbMDpOj/iu/+3r8KcI0bEBnJY0zG2vw5kYLnIbf6uFt7IPNbr3r4cEiDMVUB2Xv/BEBHDlWQpfExBeKtRM1+TPsp0BEhoAIDxmhwnmYe7uWCucdjgsC/MQ9ycdKl/leCAi4EY+CoELfn9uFFkEdgVQHS50QdUPGlluB6ydmIF5AUWQeaauDTroHReMIg4el4rCbKlpGMIb4rMeYE84Rl0RcMmXnNtjJaJhUmUQxjkL+9m9fm4Y9UXV06SegGoAyiCZNoxnWUJGA/phHrvNw4KZtIYapP1uS40bWFdxCZlpUmM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB5630.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(83380400001)(107886003)(6512007)(508600001)(36756003)(4326008)(54906003)(31686004)(44832011)(2616005)(8676002)(26005)(316002)(66556008)(66476007)(6486002)(8936002)(5660300002)(2906002)(38100700002)(86362001)(66946007)(6506007)(6666004)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Kyt5Qm1EODlqQ1F6OUlWa250MmdmNzZwS2psVERjZzAyZExKT0RLYUFjWGRi?=
 =?utf-8?B?TnQxc1NVMno1RmlHb2x3L2hJTnprcFdBdzl0N2NyaUhPdXNPb29YQkFQZ2s1?=
 =?utf-8?B?S0oyQTBudUswUFNyY2ZLdVNFZUVkcXovME5Ea1oxL0pLL3BHVk1ublJRb3F4?=
 =?utf-8?B?WVlRUWtwbXdEMVZwSkVsNWdsSzNLSkhlUkFGYmhvYTBTcUVNUjRYM0NyQkV0?=
 =?utf-8?B?aFg0OWdHQ1dySzFMcDhHdEJGcGo4Rk52UGwwVjdudmVybnF0R1d2VHlZbnRn?=
 =?utf-8?B?ZWNFWWJlc0RVSDRUSmNNb3VObGpyS2p0cUkvazZUVkZ3QjM5V1Qyb1BUa1BL?=
 =?utf-8?B?MDdPRS9ydjBtcVJpRUJPaFdabFFGbHVoQ1FTY3JoeC9CR0kzUUt5ck92d1VM?=
 =?utf-8?B?K0JaODZmYmI5aGJlV25hQjQ0Y3lWWFZqRmxKN01pbFMwdEcxeGxSc0xhencr?=
 =?utf-8?B?NjB0VFZRWGhIdHovMHlvS0hCaFliSVNHemtUNUZqWlNmaDF1ckdoMTZub0ZY?=
 =?utf-8?B?bDN4V2tLZjFCLytVZGFiSmt4eDhnbTFqWWo0K0ZvWlh0SndLZ0ZTV2Jkbnhy?=
 =?utf-8?B?K0xkMkcveXFvcW12cGxaTm1qMzRtSDdKZkJWdWNGOWNvZ0M2Q2dTRVBqTEFx?=
 =?utf-8?B?QkNnK2ZPMC9mOWxXWEozVksxUzk0ZFcwNU5LRTVyWnYrV3NVQXV6TUpsdWlD?=
 =?utf-8?B?aUlkQ3YvSkZyanZOTHlmM1FDdVRPWGZjb3FNdnJzSXp3WG8rZkRhcE9XaUVj?=
 =?utf-8?B?UkVDVi9YM2dWRjhuS1RuRGUybUt1K21Yc1pmZTY3QXZlZmJ1Y3pJbTEwb3ZG?=
 =?utf-8?B?NFYxekxLTW5WZ21hVE1hV2dUa0JyUEdDLzY2RnFWNWhiSlRJNGkxM1FxSWZJ?=
 =?utf-8?B?YStOUjVwalRrTXlxMzFzOUlTaTJzV253MUxseDZkdTcwZXZIenBJMGZOV3Zy?=
 =?utf-8?B?RXE3QnZtUzE2MmFud0pxM3hpYmo4Q1VSYzRGdWtiRzJOTkxLSmM0cStNMlcw?=
 =?utf-8?B?RzVDRzBFWndTWVN4cnRGcENTL3pqamphNmRjSnpocm9Bdlk0aTZyWjZxT245?=
 =?utf-8?B?STlIMjRRSTJ0d2F3TTgxNlk2T2xHc1RpK0FGZ0VySGhoSG1WSkwxZFppYVFt?=
 =?utf-8?B?cjM4MVBnOUp1a1YyRHIrYjVyS2VLNFcvV25kcUdQamhIYXRBY1lmY1QxMm1I?=
 =?utf-8?B?b0IvSENTR3VQbVY5YzBYZ0xvaVBWcUtzVWhRWW1wZ1JRcWdNb0plalJKWERI?=
 =?utf-8?B?TlM3MUtWZE9sV0RwNW92Z2czRHZkVng1ZlJjeDBCM2xiSGhOWWcvTEpZYy85?=
 =?utf-8?B?U0h0alFsbG5MT09YSTVraThEZllFSXBMOVptMkh4OUYxd3RwcW9qcG9RZTB2?=
 =?utf-8?B?UklPcGx1WGNhb1B5NHZWWE9GVk9yUDlmdHMxU1JMTnVoRFFKTVk1VUJoWXRw?=
 =?utf-8?B?OUsvOXFzWVhFWlMzZThKVmJwQnliMUk1dEtJWW93a3ljT2JaUFJaL29wYVU1?=
 =?utf-8?B?VUxuU05kNXFGUFltZzRPSndoVzNVTitMaGVueEI2OU9MOElQZjR4S1dZOVI5?=
 =?utf-8?B?NlpYclJhZzZYKzFBZ2hkUi9hOTJQTDdjdG9aMnE3M3l2VVpMdzBpcFgzWWJh?=
 =?utf-8?B?Ky9Dbnd3VWo3SGgwWGordXB4TzNGdEtvNURmU25vU2ZnY2Y3ZFREaVpyL1Nt?=
 =?utf-8?B?L0dNaENNaXhydDk4NnR3Q0ZzUFNhL010WTJHazREOXNpYWFNWWdFOGlYa1hD?=
 =?utf-8?B?R1RTcWZFaXRtUmRUOHZWYjYzQ0dDNXQ0ci92RHVJeHlMVUU5OGlXMmJReDZl?=
 =?utf-8?B?NEcwQ3B4MTd6ZGxhN3FqUUcvU3BzTlZ3cUhpWWl6clhPbVpDd2o3V1c1Z2c2?=
 =?utf-8?B?dmtLOFNNcXNEd1R0VDB1SCtBWUQ4cDJKRWZxM1c2VDlqa0oxZTEyREFybTZw?=
 =?utf-8?B?MjM3Y3VSem1iMjYvK0N5cTRJcVVVZW54TmlIS2dqV3NQREI5M2JCVEQzbVUy?=
 =?utf-8?B?TSs3V3ZtSkNndXVLSUVFK0dpaU5mbU5jTk85aFFNYVVid2ZReEliS3h5UkY3?=
 =?utf-8?B?SkNETTVwd0tQcjQ1TmliNUYvdmpBR0JoTVdxUkRDYnZETFRRTC9UY0FGMnBF?=
 =?utf-8?B?b0YwenBoREt2L1EvRTdLOFF0UDg4TmZ1aGNvUWxjZTk0a0FicjQ2MjlqZG9x?=
 =?utf-8?B?KzJMSHRwMWhxQzVzc2doeWw3d3k4OFRCeHAvSDdOcUNGRHB4c09UVVF5bGpM?=
 =?utf-8?B?MXdUWUxNSWRzMTV6cWNkQXlBd2JnPT0=?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e15b8935-786f-4237-b3fa-08d9da9a64f2
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB5630.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 15:51:30.5581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9vWG/fwaTQkc5M1ZJErVOASdZftTtxbfecDXW22tIY9a/u/xh1x3lpToGxlke1n9iqZPXJDJ7NVuSBdeMZxY4cFg7M9g9b4dYJyenfSybtE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3488
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

18.01.2022 18:26, Petr Vorel wrote:
> Hi all,
> 
> this is a test failure posted by Nikita Yushchenko [1]. LTP NFS test nfslock01
> looks to be failing on NFS v3:
> 
> "not unsharing /var makes AF_UNIX socket for host's rpcbind to become available
> inside ltpns. Then, at nfs3 mount time, kernel creates an instance of lockd for
> ltpns, and ports for that instance leak to host's rpcbind and overwrite ports
> for lockd already active for root namespace. This breaks nfs3 file locking."

What exactly happens is:

Test runs 'mount' in non-root netns, trying to mount a directory from root netns of the same host via nfsv3

(Part of) call chain inside the kernel

nfs_try_get_tree()
  nfs3_create_server()
   nfs_create_server()
    nfs_init_server()
     nfs_start_lockd()
      nlmclnt_init()
       lockd_up()
        svc_bind()
         svc_rpcb_setup()
          rpcb_create_local()

... and at this point it tries AF_UNIX connection to /var/run/rpcbind.sock

AF_UNIX is not netns-aware.
So it connects to host's rpcbind.
And overwrites ports registered in host's rpcbind by lockd instance for root namespace. Since this 
point, lockd instance for root namespace becomes no longer accessible (it still listens but nobody can 
learn the ports). Thus nfs locks don't work.

I'm not sure what is the correct behavior here.

Maybe rpcb_create_local() shall detect that it is not in root netns, and only try AF_INET connection to 
localhost in that case.

Maybe it shall not try AF_UNIX at all. Are there any realistic cases when rpcbind is accessible via 
AF_UNIX only?

Nikita
